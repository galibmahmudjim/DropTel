import 'package:animations/animations.dart';
import 'package:droptel/Pages/Expenses/expenses.dart';
import 'package:droptel/Pages/NewEvent.dart';
import 'package:droptel/Widget/SearchWidget.dart';
import 'package:droptel/Widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

import '../Model/Mongodb.dart';
import '../Obj/User.dart';
import '../Obj/eventWallet.dart';
import '../Widget/SearchBarWidget.dart';
import '../Widget/bottomAppBar.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
  bool search = false;
  String textControllertest = "";

  bool group = false;
  bool isLoading = false;

  Future<List<String>> fetchData() async {
    // Simulate an asynchronous data fetch.
    await Future.delayed(Duration(seconds: 2));
    return ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  }

  @override
  Widget build(BuildContext context) {
    Mongodb.getAllEvents(widget.user.id.toString());
    double height = MediaQuery.of(context).size.height;
    double width = (MediaQuery.of(context).size.width);

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
        child: Stack(
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
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: FutureBuilder<dynamic>(
                        future: search
                            ? Mongodb.getAllEventsByTitle(
                                widget.user.id.toString(), textControllertest)
                            : Mongodb.getAllEvents(widget.user.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return loading(
                                heightBox: double.maxFinite,
                                widthBox: double.maxFinite);
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            final data = snapshot.data;
                            if (data?.length == 0) {
                              return Center(
                                  child: Text(
                                'No Events',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              ));
                            }
                            return MasonryGridView.builder(
                              gridDelegate:
                                  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: data?.length,
                              itemBuilder: (context, index) {
                                eventWallet event =
                                    eventWallet.fromJson(data?[index]);
                                DateTime date =
                                    DateTime.parse(event.dateCreated!);
                                var formattedDate =
                                    DateFormat('HH:mm a\nyyyy-MMM-dd')
                                        .format(date);
                                return GridTile(
                                    child: Card(
                                  elevation: 2,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => expenses(
                                                    eventwallet: event,
                                                    user: widget.user,
                                                  )));
                                    },
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Delete Event',
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              content: Text(
                                                  'Are you sure you want to delete this event?',
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w400)),
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
                                                      Mongodb.deleteEvent(
                                                          event.sId.toString());
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
                                          left: 16.0,
                                          right: 16.0,
                                          top: 5.0,
                                          bottom: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            SizedBox(
                                                height: 10.0,
                                                width: double.maxFinite),
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
                                              event.description!
                                                      .substring(0, 25) +
                                                  '...',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                wordSpacing: 0.8,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          SizedBox(
                                              height: 20.0,
                                              width: double.maxFinite),
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
                        },
                      ),
                    ),
                    isLoading
                        ? loading(
                            heightBox: double.maxFinite,
                            widthBox: double.maxFinite)
                        : SizedBox(),
                  ],
                )),
              ]),
            ),
          ],
        ),
      ),
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
          user: widget.user,
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
}
