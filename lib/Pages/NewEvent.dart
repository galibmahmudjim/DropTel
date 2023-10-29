import 'package:droptel/Constants/colorlist.dart';
import 'package:droptel/Model/Mongodb.dart';
import 'package:droptel/Pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:objectid/src/objectid/objectid.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Obj/EventGuest.dart';
import '../Obj/User.dart';
import '../Obj/eventWallet.dart';
import '../Widget/loading.dart';
import '../Widget/snackbar.dart';

class NewEvent extends StatefulWidget {
  final User user;

  const NewEvent({required this.user});

  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  TextEditingController EventName = TextEditingController();
  TextEditingController EventDescription = TextEditingController();
  TextEditingController EventDate = TextEditingController();
  TextEditingController EventEmail = TextEditingController();
  TextEditingController EventLocation = TextEditingController();
  TextEditingController EventType = TextEditingController();
  final id = ObjectId().hexString;

  List<EventGuest> guestlist = [];
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  double height = 0;
  double width = 0;
  int typeIndex = 0;
  Map<int, Widget> items = {};
  bool flag = false;

  int widgetNumber = 3;
  final PanelController _panelController = PanelController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    EventEmail.text =
        (widget.user.email == null ? widget.user.name : widget.user.email)!;
    height = MediaQuery.of(context).size.height;
    width = (MediaQuery.of(context).size.width);

// scaffold with appbar
    return SafeArea(
      child: Scaffold(
        // SlidingUpPanel with panel and collapsed
        body: SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height,
          controller: _panelController,
          panelBuilder: SlideWidget,

          // main body or content behind the panel
          body: HomePage(user: widget.user),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
      ),
    );
  }

  Widget SlideWidget(ScrollController scrollController) {
    if (!flag) {
      items[-2] = part1();
      items[-1] = part2();
      // items.add(part1());
      // items.add(part2());
      EventGuest eventGuest = EventGuest.fromJson({
        "Index": typeIndex,
        "Name": widget.user.name,
        "Email": widget.user.email == null ? "" : widget.user.email,
        "Color": colorsList[typeIndex].toString()
      });
      guestlist.add(eventGuest);
      items[typeIndex] = eventMemberGuest(typeIndex, eventGuest, context);
      print(items.length);
      typeIndex++;

      flag = true;
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: items.length + 1,
                    itemBuilder: (context, index) {
                      return Builder(
                        builder: (context) {
                          return Focus(
                            onFocusChange: (value) {
                              if (value) {
                                if (!_panelController.isPanelOpen) {
                                  _panelController.open();
                                }
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Builder(
                                builder: (context) {
                                  return index == items.length
                                      ? Container(
                                          height: 20,
                                        )
                                      : items.values.elementAt(index);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            isLoading
                ? Opacity(
                    opacity: 0.5,
                    child: loading(
                        heightBox: MediaQuery.of(context).size.height,
                        widthBox: MediaQuery.of(context).size.width))
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget eventNameWidget() {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 10),
      margin: EdgeInsets.only(bottom: 10, top: 10),
      height: height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)),
      ),
      child: TextFormField(
        controller: EventName,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Name';
          }
          return null;
        },
        cursorColor: Colors.black,
        style: TextStyle(
          fontSize: 25,
          fontFamily: GoogleFonts.prompt(
            letterSpacing: 1,
            color: Color(0xFF464647),
          ).fontFamily,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          color: Color(0xFF464647),
        ),
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          errorStyle: TextStyle(height: 0, fontSize: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          hintText: 'Add Name',
          hintStyle: TextStyle(
            fontFamily: GoogleFonts.prompt().fontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF464647),
          ),
        ),
      ),
    ); //Event Name
  }

  Widget eventDescriptionWidget() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: height * 0.1,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Color(0x73706B6B)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              left: 10,
            ),
            width: width * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            child: Opacity(opacity: 0.5, child: Icon(Icons.description)),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: EventDescription,
                cursorColor: Colors.black,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: GoogleFonts.prompt(
                    letterSpacing: 1,
                    color: Color(0xFF464647),
                  ).fontFamily,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF464647),
                ),
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  errorStyle: TextStyle(height: 0, fontSize: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Event Description',
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.prompt().fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF464647),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ); //Event Description
  }

  Widget eventDateWidget() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: height * 0.1,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Color(0x73706B6B)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              left: 10,
            ),
            width: width * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            child: Opacity(opacity: 0.5, child: Icon(Icons.calendar_today)),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: TextFormField(
                readOnly: true,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(3000),
                  ).then((value) {
                    if (value != null) {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value1) => {
                            if (value1 != null)
                              {
                                setState(() {
                                  EventDate.text = value.day.toString() +
                                      "/" +
                                      value.month.toString() +
                                      "/" +
                                      value.year.toString() +
                                      " " +
                                      (value1.hour % 12)
                                          .toString()
                                          .padLeft(2, '0') +
                                      ":" +
                                      value1.minute.toString().padLeft(2, '0') +
                                      " " +
                                      value1.period.toString().split('.')[1];
                                })
                              }
                          });
                    }
                  });
                },
                controller: EventDate,
                cursorColor: Colors.black,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: GoogleFonts.prompt(
                    letterSpacing: 1,
                    color: Color(0xFF464647),
                  ).fontFamily,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF464647),
                ),
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  errorStyle: TextStyle(height: 0, fontSize: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Event Date',
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.prompt().fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF464647),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ); //Event Date
  }

  Widget eventEmailWidget() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: height * 0.1,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Color(0x73706B6B)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              child: Container(
                  child: CircleAvatar(
                radius: 13,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    'assets/cat.jpeg',
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                  ),
                ),
              ))),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5),
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: EventEmail,
                readOnly: true,
                cursorColor: Colors.black,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: GoogleFonts.prompt(
                    letterSpacing: 1,
                    color: Color(0xFF464647),
                  ).fontFamily,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF464647),
                ),
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  errorStyle: TextStyle(height: 0, fontSize: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Event Email',
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.prompt().fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF464647),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ); //Event Email
  }

  bool tapped = false;
  bool cancelTap = false;

  Widget eventMemberGuest(int index, EventGuest guest, BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          tapped = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          tapped = false;
        });
      },
      onTap: () {
        setState(() {
          cancelTap = !cancelTap;
        });
      },
      child: Container(
        height: 70,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.cyan[50],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              extentRatio: 0.25,
              dragDismissible: false,
              motion: ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {}),
              children: <Widget>[
                SlidableAction(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  onPressed: (context) {
                    if (index > 0)
                      setState(() {
                        items.remove(index);
                        guestlist.remove(guest);
                      });
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          guest.name!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        if (!guest.email!.isEmpty)
                          SizedBox(
                            height: 5,
                          ),
                        if (!guest.email!.isEmpty)
                          Text(guest.email!,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black)),
                      ],
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(colorsList[guest.index!]),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget eventAddPeopleWidget() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: height * 0.1,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Color(0x73706B6B)),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              //AddPeople
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: 10,
                ),
                width: width * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
                child: Opacity(opacity: 0.5, child: Icon(Icons.people)),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      GlobalKey<FormState> popupkey = GlobalKey<FormState>();
                      TextEditingController EventguestName =
                          TextEditingController();
                      TextEditingController EventguestEmail =
                          TextEditingController();

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text('New Guest'),
                              content: Container(
                                width: width * 0.9,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Form(
                                    key: popupkey,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: EventguestName,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter Name';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Name',
                                            icon: Icon(Icons.account_box),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: EventguestEmail,
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                            icon: Icon(Icons.email),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                    child: Text("ADD"),
                                    onPressed: () {
                                      if (popupkey.currentState!.validate()) {
                                        setState(() {
                                          EventGuest eventGuest =
                                              EventGuest.fromJson({
                                            "Index": typeIndex,
                                            "Name": EventguestName.text,
                                            "Email": EventguestEmail.text,
                                            "Color":
                                                colorsList[typeIndex].toString()
                                          });

                                          setState(() {
                                            guestlist.add(eventGuest);
                                            items[typeIndex] = eventMemberGuest(
                                                typeIndex, eventGuest, context);
                                            print(items.length);
                                            typeIndex++;
                                          });
                                        });
                                        Navigator.of(context).pop();
                                      }
                                    })
                              ],
                            );
                          });
                    },
                    child: Text(
                      "Add People",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.prompt(
                          letterSpacing: 1,
                          color: Color(0xFF464647),
                        ).fontFamily,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF464647),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ), //Type
    ); //AddPeople
  }

  Widget part1() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)),
          Text(
            "New Event",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0x99000000)),
          ),
          IconButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  eventWallet event = eventWallet.fromJson({
                    "_id": id,
                    "Title": EventName.text,
                    "Description": EventDescription.text,
                    "Date": EventDate.text,
                    "DateCreated": DateTime.now().toString(),
                    "AdminId": widget.user.id,
                    "AdminEmail": EventEmail.text,
                    "EventGuest": guestlist.map((e) => e.toJson()).toList()
                  });
                  setState(() {
                    isLoading = true;
                  });
                  var res = Mongodb.addNewEvent(event);
                  res.timeout(Duration(seconds: 5), onTimeout: () {
                    setState(() {
                      isLoading = false;
                      snackBar(
                          context, "Check internet Connection", Colors.red);
                    });
                  }).then((value) => {
                        if (value != null)
                          {
                            setState(() {
                              isLoading = false;
                            }),
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          user: widget.user,
                                        )))
                          }
                        else
                          {
                            setState(() {
                              isLoading = false;
                            }),
                            snackBar(
                                context, "Something went wrong", Colors.red)
                          }
                      });
                }
              },
              icon: Icon(Icons.check))
        ],
      ),
    );
  }

  Widget part2() {
    return Form(
      key: formkey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            eventNameWidget(),
            eventDescriptionWidget(),
            eventDateWidget(),
            eventEmailWidget(), //Email
            eventAddPeopleWidget(),
          ],
        ),
      ),
    );
  }
}
