import 'package:droptel/Model/Mongodb.dart';
import 'package:droptel/Obj/ActivityList.dart';
import 'package:droptel/Obj/Wallet.dart';
import 'package:droptel/Obj/eventWallet.dart';
import 'package:droptel/Widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Obj/User.dart';
import '../Widget/snackbar.dart';

class EventHomePage extends StatefulWidget {
  final eventWallet eventwallet;
  final User user;
  const EventHomePage({
    required this.eventwallet,
    required this.user,
  });

  @override
  State<EventHomePage> createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage> {
  eventWallet? eventwallet;
  User? user;
  Wallet? wallet;

  bool isLoading = false;

  getWalletDetails() async {
    isLoading = true;
    Future<dynamic>? result = Mongodb.FindEventDetails(eventwallet!.sId!);
    result
        ?.then((value) => {
              if (value != null)
                {
                  setState(() {
                    isLoading = false;
                    wallet = Wallet.fromJson(value);
                    wallet!.activityList!
                        .sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
                  })
                }
              else
                {
                  setState(() {
                    isLoading = false;
                    wallet = null;
                  })
                }
            })
        .timeout(const Duration(seconds: 10), onTimeout: () {
      setState(() {
        isLoading = false;
        wallet = null;
      });

      return snackBar(context, "Something went wrong", Colors.redAccent);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventwallet = widget.eventwallet;
    user = widget.user;
    getWalletDetails();
  }

  double height = 0;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7)),
          backgroundColor: Colors.white.withOpacity(0.4),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.summarize,
                  color: Colors.black.withOpacity(0.7),
                )),
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.black.withOpacity(0.7),
                ))
          ],
          title: Text(
            eventwallet!.title ?? "Event",
            style: GoogleFonts.lato(
                color: Colors.green.withOpacity(0.8),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          shadowColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Opacity(
              opacity: 0.1,
              child: Container(
                height: 0.5,
              ),
            ),
          )),
      body: MainBody(),
    );
  }

  MainBody() {
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: AllActivity(),
          ),
          isLoading ? loading(heightBox: height, widthBox: width) : Container(),
        ],
      ),
    );
  }

  AllActivity() {
    return SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                getWalletDetails();
              });
            },
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Container(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return activityList();
                },
              ))
            ]))));
  }

  activityList() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(),
          height: height,
          width: width,
          child: Column(children: [
            Expanded(
                child: Container(
                    child: ListView.builder(
              shrinkWrap: true,
              itemCount: wallet?.activityList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return activityCard(wallet!.activityList![index]);
              },
            )))
          ]),
        ),
      ],
    );
  }

  activityCard(ActivityList activityList) {
    return Card(
        child: Text(
            "${activityList.title} ${activityList.dateTime}" ?? "No Title"));
  }
}
