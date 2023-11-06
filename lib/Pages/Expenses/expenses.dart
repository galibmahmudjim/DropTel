import 'dart:core';

import 'package:droptel/Constants/Logger.dart';
import 'package:droptel/Obj/EventGuest.dart';
import 'package:droptel/Obj/eventWallet.dart';
import 'package:droptel/Widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../Obj/User.dart';

class expenses extends StatefulWidget {
  final eventWallet eventwallet;
  final User user;

  const expenses({Key? key, required this.eventwallet, required this.user})
      : super(key: key);

  @override
  State<expenses> createState() => _expensesState();
}

class _expensesState extends State<expenses> {
  bool isLoading = false;
  bool isNewActivityCreated = false;
  double height = 0;
  double width = 0;

  //multiselect guest list data
  List<EventGuest?> selectedGuests = [];
  List<EventGuest?> selectedGuestsInit = [];
  List<MultiSelectItem<EventGuest?>?>? selectedGuestsShow = [];
  List<MultiSelectItem<EventGuest>> selectGuests = [];
  EventGuest allGuest = EventGuest(name: "All", email: "");
  bool flagall = false;
  //multiset guest end

  //statement or activity
  int buttonSeleted = 1;
  //statement or activity end

  // new statement
  List<String> list = <String>['Payment', 'Expenditure'];
  var guestListSelected = [];
  String? dropdownValue;
  int actionSelected = 1;
  final _multiSelectKey = GlobalKey<FormFieldState>();
  // new state end

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
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
      body: Body(),
    );
  }

  Widget Body() {
    String unicodeString = '\u09F3';
    DateTime date = DateTime.parse(widget.eventwallet.dateCreated.toString());
    var formattedDate = DateFormat('HH:mm a\nyyyy-MMM-dd').format(date);
    return Center(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/expenseBG.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: width,
                          color: Colors.white54,
                          child: Container(
                            padding: EdgeInsets.only(left: 30, top: 10),
                            child: Text(
                              widget.eventwallet.title.toString(),
                              style: GoogleFonts.lato(
                                  color: Colors.black54,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ), //title
                        Container(
                          width: width,
                          color: Colors.white54,
                          child: Container(
                            padding: EdgeInsets.only(left: 32, top: 5),
                            child: Text(
                              widget.eventwallet.description.toString(),
                              style: GoogleFonts.lato(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ), //description
                        Expanded(
                          child: Container(
                              width: width,
                              padding: EdgeInsets.only(left: 10, top: 30),
                              color: Colors.white54,
                              child: Row(
                                children: [
                                  Opacity(
                                    opacity: 0.3,
                                    child: CircleAvatar(
                                      radius: width * 0.04,
                                      backgroundColor: Colors.black12,
                                      child: Icon(
                                        size: width * 0.04,
                                        Icons.calendar_today,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    formattedDate.toString(),
                                    style: GoogleFonts.notoSans(
                                        color: Colors.black54,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ), //Date
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: height / 7, left: width * 0.48),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Expense Summery",
                                style: GoogleFonts.notoSans(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                      String.fromCharCodes(unicodeString.runes),
                                      style: GoogleFonts.notoSans(
                                          color: Colors.black54,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "10000",
                                style: GoogleFonts.notoSans(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ), //Amount
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Create new ${buttonSeleted == 1 ? "Statement" : "Activity"}",
                        style: GoogleFonts.notoSans(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ), //title create
                    Container(
                      width: width,
                      // To ensure the container spans the full width.
                      child: Opacity(
                        opacity: 0.3,
                        child: Divider(
                          color: Colors.black, // Color of the line.
                          thickness: 0.9, // Thickness of the line.
                        ),
                      ),
                    ), //underline
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  buttonSeleted = 1;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    width: 1,
                                    color: buttonSeleted == 1
                                        ? Colors.redAccent
                                        : Colors.greenAccent),
                                // Set border width
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text(
                                "Statement",
                                style: GoogleFonts.notoSans(
                                    color: buttonSeleted == 1
                                        ? Colors.redAccent
                                        : Colors.greenAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                          OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  buttonSeleted = 2;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.only(left: 30, right: 30),
                                side: BorderSide(
                                    width: 1,
                                    color: buttonSeleted == 2
                                        ? Colors.redAccent
                                        : Colors.greenAccent),
                                // Set border width
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text(
                                "Activity",
                                style: GoogleFonts.notoSans(
                                    color: buttonSeleted == 2
                                        ? Colors.redAccent
                                        : Colors.greenAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ), //radio button
                    SizedBox(
                      height: 10,
                    ),
                    buttonSeleted == 1 ? newStatement() : newActivity(),
                  ],
                ),
              ))
            ],
          ),
          isLoading
              ? loading(heightBox: double.maxFinite, widthBox: double.maxFinite)
              : SizedBox(),
        ],
      ),
    );
  }

  Widget newStatement() {
    TextEditingController controller = TextEditingController();

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.centerLeft,
          child: DropdownMenu<String>(
            width: width * 0.35,
            initialSelection: list.first,
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                if (dropdownValue == "Payment") {
                  actionSelected = 1;
                } else {
                  actionSelected = 2;
                }
              });
            },
            dropdownMenuEntries:
                list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
        ), //action dropdown
        multiselectGuest(),
      ],
    );
  }

  multiselectGuest() {
    TextEditingController controller = TextEditingController();
    selectGuests.clear();
    selectGuests.add(MultiSelectItem(allGuest, "All"));
    widget.eventwallet.eventGuest!.forEach((element) {
      selectGuests.add(MultiSelectItem(element,
          "${element.name.toString()}  ${element!.email!.isEmpty ? "" : "(${element.email.toString()})"}"));
    });

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.4),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      child: Column(
        children: <Widget>[
          MultiSelectBottomSheetField(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.4),
              border: Border.all(
                color: Colors.black26,
                width: 1,
              ),
            ),
            confirmText: Text(
              "OK",
              style: GoogleFonts.notoSans(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            cancelText: Text(
              "CANCEL",
              style: GoogleFonts.notoSans(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            buttonIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            initialChildSize: 0.4,
            listType: MultiSelectListType.LIST,
            searchable: true,
            isDismissible: true,
            buttonText: Text("Include members (${selectedGuests.length})",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
            title: Text("Members"),
            items: selectGuests,
            initialValue: selectedGuestsInit,
            selectedColor: Colors.greenAccent,
            onConfirm: (values) {
              bool prevflag = flagall;
              if (values.contains(allGuest)) {
                flagall = true;
              } else {
                flagall = false;
              }
              logger.d("flagall $flagall\n prevflag $prevflag");
              if (flagall && !prevflag) {
                setState(() {
                  selectedGuests = selectGuests
                      .where((element) => element.value != allGuest)
                      .map((e) => e.value)
                      .toList();
                });
                setState(() {
                  selectedGuestsInit =
                      selectGuests.map((e) => e.value).toList();
                });
              } else if (!flagall && prevflag) {
                flagall = false;
                setState(() {
                  selectedGuests = [];
                  selectedGuestsInit = [];
                });
              } else {
                setState(() {
                  selectedGuestsInit = values;
                  selectedGuests =
                      values.where((element) => element != allGuest).toList();
                });
                if (values.length != selectGuests.length) {
                  flagall = false;
                  setState(() {
                    selectedGuestsInit = selectedGuestsInit
                        .where((element) => element != allGuest)
                        .toList();
                  });
                }
              }
            },
            chipDisplay: MultiSelectChipDisplay(
              scroll: true,
              items: selectedGuestsShow,
              textStyle: GoogleFonts.notoSans(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              decoration: BoxDecoration(),
              onTap: (e) {
                if (e == allGuest) {
                  flagall = false;
                  setState(() {
                    selectedGuestsInit = [];
                  });
                } else {
                  if (selectedGuestsInit.contains(allGuest)) {
                    flagall = false;
                    setState(() {
                      selectedGuestsInit = selectedGuestsInit
                          .where((element) => element != allGuest)
                          .toList();
                    });
                  }
                  setState(() {
                    selectedGuestsInit = selectedGuestsInit
                        .where((element) => element != e)
                        .toList();
                    selectedGuests = selectedGuests
                        .where((element) => element != e)
                        .toList();
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget newActivity() {
    return Container(
      child: Text("Activity"),
    );
  }
}
