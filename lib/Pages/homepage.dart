import 'package:animations/animations.dart';
import 'package:droptel/Pages/EventHomePage.dart';
import 'package:droptel/Pages/NewEvent.dart';
import 'package:droptel/Widget/SearchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Model/Mongodb.dart';
import '../Obj/User.dart';
import '../Obj/eventWallet.dart';
import '../Widget/SearchBarWidget.dart';
import '../Widget/bottomAppBar.dart';
import '../Widget/loading.dart';
import '../homeLogin.dart';

class HomePage extends StatefulWidget {
  final User? user;
  final String? id;
  final String? name;

  const HomePage({this.user, this.id, this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
  bool search = false;
  String textControllertest = "";

  bool group = false;
  bool isLoading = false;
  User user = User();
  bool timeout = false;
  Future<void> checkLoggedIn() async {
    isLoading = true;
    var temp =
        await Mongodb.connect().timeout(Duration(seconds: 5), onTimeout: () {
      setState(() {
        timeout = true;
        isLoading = false;
      });
    });
    if (widget.id != null && widget.name != null) {
      Future<dynamic> res =
          Mongodb.findUser(widget.id.toString(), widget.name.toString());

      await res.then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
            timeout = false;
            user = User.fromJson(value);
          });
        } else {
          setState(() {
            timeout = false;
            isLoading = false;
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomePageLogin()));
        }
      });
      if (user != null) {
        print(user.toJson());
      } else {
        setState(() {
          timeout = false;
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePageLogin()));
      }
    } else {
      setState(() {
        timeout = false;
        isLoading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePageLogin()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isLoading = true;
    if (widget.user != null) {
      isLoading = false;
      user = widget.user!;
    } else {
      checkLoggedIn();
    }
  }

  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = (MediaQuery.of(context).size.width);

    return Scaffold(
        floatingActionButton: MyFloatingActionButton(),

        //floating action button location to left
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: bottomAppBar(),
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  checkLoggedIn();
                });
              },
              notificationPredicate: (ScrollNotification notification) {
                return notification.depth == 1;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return MainBody();
                        },
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }

  MainBody() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(),
          height: height,
          width: width,
          child: Column(children: [
            Container(
                child: search
                    ? SearchWidget(
                        boxheight: height,
                        boxwidth: width,
                        callback: (bool? value) {
                          setState(() {
                            if (value == true) {
                              search = false;
                            }
                          });
                        },
                        callbackText: (String? value) {
                          setState(() {
                            textControllertest = value!;
                          });
                        },
                      )
                    : SearchBarWidget(
                        boxheight: height,
                        boxwidth: width,
                        callback: (bool? value) {
                          setState(() {
                            if (value == true) {
                              search = true;
                            }
                          });
                        },
                      )),
            Expanded(
                child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: FutureBuilder<dynamic>(
                    future: search
                        ? Mongodb.getAllEventsByTitle(
                            user.id.toString(), textControllertest)
                        : Mongodb.getAllEvents(user.id.toString()),
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
                        if (data?.length == 0) {
                          return Center(
                              child: Text(
                            'No Events',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ));
                        }
                        return NotificationListener<
                                OverscrollIndicatorNotification>(
                            onNotification: (overscroll) {
                              overscroll.disallowIndicator();
                              return true;
                            },
                            child: walletBuild(data));
                      }
                    },
                  ),
                ),
                isLoading
                    ? loading(
                        heightBox: double.maxFinite, widthBox: double.maxFinite)
                    : SizedBox(),
              ],
            )),
          ]),
        ),
      ],
    );
  }

  Widget MyFloatingActionButton() {
    return OpenContainer(
      openElevation: 5.0,
      closedElevation: 0.0,
      transitionType: ContainerTransitionType.fadeThrough,
      closedShape: CircleBorder(),
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (BuildContext context, VoidCallback _) {
        return NewEvent(
          user: user,
        );
      },
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: openContainer,
          child: Icon(Icons.add),
        );
      },
    );
  }

  Widget walletBuild(data) {
    return MasonryGridView.builder(
      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: data?.length,
      itemBuilder: (context, index) {
        eventWallet event = eventWallet.fromJson(data?[index]);
        DateTime date = DateTime.parse(event.dateCreated!);
        var formattedDate = DateFormat('HH:mm a\nyyyy-MMM-dd').format(date);
        return GridTile(
            child: Card(
          elevation: 2,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventHomePage(
                            eventwallet: event,
                            user: user,
                          )));
            },
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete Event',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500)),
                      content: Text(
                          'Are you sure you want to delete this event?',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w400)),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              Mongodb.deleteEvent(event.sId.toString());
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                            },
                            child: Text('Delete')),
                      ],
                    );
                  });
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 5.0, bottom: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data?[index]['Title'] ?? ' ',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'sans-serif',
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  if (!event.description!.isEmpty)
                    SizedBox(height: 10.0, width: double.maxFinite),
                  if (!event.description!.isEmpty &&
                      (event.description!.length < 25))
                    Text(
                      event.description.toString(),
                      style: TextStyle(
                        fontSize: 15.0,
                        wordSpacing: 0.8,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  if (!event.description!.isEmpty &&
                      (event.description!.length >= 25))
                    Text(
                      event.description!.substring(0, 25) + '...',
                      style: TextStyle(
                        fontSize: 15.0,
                        wordSpacing: 0.8,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  SizedBox(height: 20.0, width: double.maxFinite),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 13.0,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w400,
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
