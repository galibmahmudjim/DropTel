import 'package:droptel/Model/Mongodb.dart';
import 'package:droptel/Obj/Activity.dart';
import 'package:droptel/Obj/ActivityList.dart';
import 'package:droptel/Obj/Statement.dart';
import 'package:droptel/Obj/Wallet.dart';
import 'package:droptel/Obj/eventWallet.dart';
import 'package:droptel/Pages/Expenses/expenses.dart';
import 'package:droptel/Widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Constants/Logger.dart';
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
  eventWallet? Eventwallet;
  User? user;
  Wallet? wallet;

  bool isLoading = false;

  Future<void> getWalletDetails() async {
    isLoading = true;
    Future? result = Mongodb.FindEventDetails(Eventwallet!.sId!);
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
    Eventwallet = widget.eventwallet;
    user = widget.user;
    if (wallet == null) {
      getWalletDetails();
      isLoading = false;
    } else {
      isLoading = false;
      wallet!.activityList!.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
    }
  }

  double height = 0;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return expenses(
              eventwallet: Eventwallet!,
              user: user!,
            );
          }));
          setState(() {});
        },
        label: Text(
          "Add Expense",
          style: GoogleFonts.lato(
              color: Colors.white.withOpacity(0.8),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white.withOpacity(0.8),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.lightBlueAccent,
          iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.summarize,
                  color: Colors.black.withOpacity(0.7),
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return expenses(
                      eventwallet: Eventwallet!,
                      user: user!,
                    );
                  }));
                  setState(() {});
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.black.withOpacity(0.7),
                ))
          ],
          title: Text(
            Eventwallet?.title ?? "Event",
            style: GoogleFonts.lato(
                color: Colors.white.withOpacity(0.8),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          shadowColor: Colors.lightBlue,
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
    ));
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
              await getWalletDetails();
            },
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return activityList();
                  },
                ),
              )
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
                child: FutureBuilder<dynamic>(
                  future: Mongodb.FindEventDetails(Eventwallet!.sId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return loading(
                          heightBox: double.maxFinite,
                          widthBox: double.maxFinite);
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Container(
                        child: Text(
                          'Connection Error',
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.red),
                        ),
                      ));
                    } else {
                      final data = snapshot.data;
                      if (data?.length == 0 || data == null) {
                        return Center(
                            child: Text(
                          'No Activity Found',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                        ));
                      } else {
                        wallet = Wallet.fromJson(data);
                      }
                      return NotificationListener<
                          OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                        child: ListView.builder(
                          padding:
                              EdgeInsets.only(top: 20, bottom: height * 0.4),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: wallet?.activityList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            wallet!.activityList!.sort(
                                (a, b) => b.dateTime!.compareTo(a.dateTime!));
                            return makeListTile(wallet!.activityList![index]);
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }

  makeListTile(ActivityList items) {
    DateTime dateTime = DateTime.parse(items!.dateTime!);
    DateFormat formatter = DateFormat('hh:mm aa\ndd-MMM-yyyy');
    String formatted = formatter.format(dateTime);
    return items.type == "Activity"
        ? CardActivity(items, formatted)
        : CardStatement(items, formatted);
  }

  CardStatement(ActivityList items, String formatted) {
    return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: items.type == "Activity"
            ? Colors.lightBlueAccent
            : (items as Statement).statementType == "Payment"
                ? Colors.lime
                : Colors.green,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: () {
            logger.d("Tapped");
          },
          child: IntrinsicHeight(
              child: Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: width * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(items.title ?? "Title",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (items.type == "Activity" &&
                                      ((items as Activity).description !=
                                              null &&
                                          (items).description != ""))
                                    Text(items.description!,
                                        style: TextStyle(color: Colors.white)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(formatted ?? "Date",
                                      style: GoogleFonts.inter(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                          child: Container(
                        width: width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "${(items as Statement).statementType == "Payment" ? "Payemnt" : "Expenditure"}: ",
                                    style: GoogleFonts.robotoMono(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: Text(
                                        "${(items as Statement).statementType == "Payment" ? (items.amount! * -1).toString() : items.amount.toString()}",
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                            if ((items as Statement).statementType ==
                                    "Expenditure" &&
                                items.isCustomOperation == true)
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        items.calculationTitle ?? "Title",
                                        style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${items.operation == "Percentage (%)" ? "%" : items.operation == "Addition (+)" ? "+" : items.operation == "Subtraction (-)" ? "-" : items.operation == "Multiplication (x)" ? "x" : "/"}",
                                        style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        items.operationValue.toString(),
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            if ((items as Statement).statementType ==
                                "Expenditure")
                              Row(
                                children: [
                                  Text("Subtotal: ",
                                      style: GoogleFonts.robotoMono(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                      child: Text(
                                          (items as Statement).total.toString(),
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.robotoMono(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold))),
                                ],
                              ),
                            Row(
                              children: [
                                Text("Total Member: ",
                                    style: GoogleFonts.robotoMono(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: Text(
                                        (items as Statement)
                                            .countMembers
                                            .toString(),
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Total: ",
                                    style: GoogleFonts.robotoMono(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: Text(
                                        "${(items as Statement).statementType == "Payment" ? (items.totalWithMembers! * -1).toString() : items.totalWithMembers.toString()}",
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ],
                        ),
                      )),
                    ],
                  )
                ],
              ),
            ),
          )),
        ));
  }

  CardActivity(ActivityList items, String formatted) {
    return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: items.type == "Activity"
            ? Colors.lightBlueAccent
            : (items as Statement).statementType == "Payment"
                ? Colors.lime
                : Colors.green,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: () {
            logger.d("Tapped");
          },
          child: IntrinsicHeight(
              child: Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: width * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(items.title ?? "Title",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (items.type == "Activity" &&
                                      ((items as Activity).description !=
                                              null &&
                                          (items).description != ""))
                                    Text(items.description!,
                                        style: TextStyle(color: Colors.white)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(formatted ?? "Date",
                                      style: GoogleFonts.inter(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                          child: Container(
                        width: width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text("Expenses: ",
                                    style: GoogleFonts.robotoMono(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text("Paid: ",
                                    style: GoogleFonts.robotoMono(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      )),
                    ],
                  )
                ],
              ),
            ),
          )),
        ));
  }
}
