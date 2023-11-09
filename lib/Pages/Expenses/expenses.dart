import 'dart:core';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:droptel/Constants/Logger.dart';
import 'package:droptel/Obj/EventGuest.dart';
import 'package:droptel/Obj/eventWallet.dart';
import 'package:droptel/Widget/loading.dart';
import 'package:droptel/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  TextEditingController statementNameController = TextEditingController();

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo[800],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Center(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.25,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage("assets/expenseBG.jpg"),
                                fit: BoxFit.cover,
                                opacity: 0.3,
                              ),
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
                                        padding:
                                            EdgeInsets.only(left: 30, top: 10),
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
                                        padding:
                                            EdgeInsets.only(left: 32, top: 5),
                                        child: Text(
                                          widget.eventwallet.description
                                              .toString(),
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
                                          padding: EdgeInsets.only(
                                              left: 10, top: 30),
                                          color: Colors.white54,
                                          child: Row(
                                            children: [
                                              Opacity(
                                                opacity: 0.3,
                                                child: CircleAvatar(
                                                  radius: width * 0.04,
                                                  backgroundColor:
                                                      Colors.black12,
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                    ), //Date
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: height / 7, left: width * 0.48),
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
                                                  String.fromCharCodes(
                                                      unicodeString.runes),
                                                  style: GoogleFonts.notoSans(
                                                      color: Colors.black54,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold))),
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
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Create new ${buttonSeleted == 1 ? "Statement" : "Activity"}",
                            style: GoogleFonts.notoSans(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ), //title create
                        Container(
                          width: width * 0.9,
                          // To ensure the container spans the full width.
                          child: Opacity(
                            opacity: 0.3,
                            child: Divider(
                              color: Colors.white, // Color of the line.
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                    side: BorderSide(
                                        width: 1,
                                        color: buttonSeleted == 2
                                            ? Colors.redAccent
                                            : Colors.greenAccent),
                                    // Set border width
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                  ),
                ))
              ],
            ),
            isLoading
                ? loading(
                    heightBox: double.maxFinite, widthBox: double.maxFinite)
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget newStatement() {
    TextEditingController controller = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          AddTitle(),
          SizedBox(
            height: 10,
          ),
          multiselectGuest(),
          Container(
            height: 10,
            margin: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 1, color: Color(0x73706B6B)),
            )),
          ),
          SizedBox(height: 20),
          PaymentDropDown(), //action dropdown
          SizedBox(
            height: 10,
          ),
          if (actionSelected == 1) PaymentAction() else ExpenditureAction(),
          SizedBox(
            height: 10,
          ),
          AddExpensesButton(),
        ],
      ),
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
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: <Widget>[
          MultiSelectBottomSheetField(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
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
              color: Colors.white,
            ),
            initialChildSize: 0.4,
            listType: MultiSelectListType.LIST,
            searchable: true,
            isDismissible: true,
            buttonText: Text("Include members (${selectedGuests.length})",
                style: GoogleFonts.poppins(
                    color: Colors.white,
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
                    selectedGuests = [];
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

  PaymentDropDown() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: DropdownMenu<String>(
                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  errorStyle: TextStyle(height: 0, fontSize: 0),
                ),
                trailingIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                textStyle: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
                initialSelection: list.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                    if (dropdownValue == "Payment") {
                      setState(() {
                        actionSelected = 1;
                        ammountFlag = true;
                      });
                    } else {
                      setState(() {
                        actionSelected = 2;
                        ammountFlag = false;
                      });
                    }
                  });
                },
                dropdownMenuEntries:
                    list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ),
            Amount(),
          ],
        ),
      ),
    );
  }

  AddTitle() {
    TextEditingController statementNameController = TextEditingController();
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        // border: Border.all(
        //   color: Colors.black26,
        //   width: 1,
        // ),
      ),
      child: TextFormField(
        controller: statementNameController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Name';
          }
          return null;
        },
        cursorColor: Colors.white,
        style: TextStyle(
          fontSize: 17,
          fontFamily: GoogleFonts.prompt(
            color: Color(0xFF464647),
          ).fontFamily,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          border: InputBorder.none,
          errorStyle: TextStyle(height: 0, fontSize: 0),
          hintText: 'Add Title',
          hintStyle: TextStyle(
            fontFamily: GoogleFonts.prompt().fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }

  PaymentAction() {
    return Container();
  }

  ExpenditureAction() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 1, color: Color(0x74F1EBEB)),
          )),
          margin: EdgeInsets.only(left: 10, right: 10),
          width: width,
          child: IntrinsicHeight(
            child: Row(
              children: [
                CustomCalculateButton(),
              ],
            ),
          ),
        ),
        if (checkboxValue) CustomCalculationProperty(),
      ],
    );
  }

  CustomCalculationProperty() {
    TextEditingController customCalculationTitleController =
        TextEditingController();
    return Card(
      elevation: 1,
      child: Container(
        decoration: BoxDecoration(),
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        width: width,
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: customCalculationTitleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Title';
                  }
                  return null;
                },
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: GoogleFonts.poppins(
                    color: Color(0xFF464647),
                  ).fontFamily,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF464647),
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 0.1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 0.1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 0.1,
                    ),
                  ),
                  errorStyle: TextStyle(height: 0, fontSize: 0),
                  hintText: 'Title (Ex. VAT, Service Charge)',
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.prompt().fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Color(0x71464647),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    child: dropDownMenuCalculation(),
                  )),
                  Container(
                    width: width * 0.45,
                    child: OperationValue(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController operationValueController = TextEditingController();
  OperationValue() {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: TextFormField(
          controller: operationValueController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Value';
            }
            return null;
          },
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black26,
                width: 0.1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black26,
                width: 0.1,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black26,
                width: 0.1,
              ),
            ),
            errorStyle: TextStyle(height: 0, fontSize: 0),
            hintText: 'Value',
            hintStyle: TextStyle(
              fontFamily: GoogleFonts.prompt().fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Color(0x71464647),
            ),
          ),
          style: TextStyle(
            fontSize: 15,
            fontFamily: GoogleFonts.poppins(
              color: Color(0xFF464647),
            ).fontFamily,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w900,
            color: Color(0xFF464647),
          ),
        ));
  }

  final List<String> items = [
    'Percentage (%)',
    'Addition (+)',
    'Subtraction (-)',
    'Multiplication (x)',
    'Division (/)',
  ];
  String? selectedValueOperation;
  dropDownMenuCalculation() {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 0.1,
        ),
      ),
      child: Column(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              alignment: Alignment.center,
              isExpanded: true,
              hint: Text(
                'Select Operation',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
              items: items
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                  .toList(),
              value: selectedValueOperation,
              onChanged: (String? value) {
                setState(() {
                  selectedValueOperation = value;
                });
              },
              dropdownStyleData: DropdownStyleData(
                width: width * 0.5,
              ),
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool checkboxValue = false;
  CustomCalculateButton() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Checkbox(
                checkColor: Colors.white,
                value: checkboxValue,
                activeColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    checkboxValue = value!;
                  });
                }),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: width * 0.01),
              child: InkWell(
                onTap: () {
                  setState(() {
                    checkboxValue = !checkboxValue;
                  });
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Custom Calculation",
                    style: GoogleFonts.notoSans(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool ammountFlag = true;
  Amount() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1.2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: statementNameController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        ammountFlag = true;
                      });
                    } else {
                      setState(() {
                        ammountFlag = false;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Amount';
                    }
                    return null;
                  },
                  cursorColor: Colors.white,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: GoogleFonts.prompt(
                      color: Color(0xFF464647),
                    ).fontFamily,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF464647),
                  ),
                  textAlignVertical: TextAlignVertical.bottom,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(height: 0, fontSize: 0),
                    hintText: 'Amount',
                    hintStyle: TextStyle(
                      fontFamily: GoogleFonts.prompt().fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
            !ammountFlag
                ? Container()
                : Container(
                    child: IconButton(
                        highlightColor: Colors.white,
                        onPressed: () {
                          // snackBar(
                          //     context,
                          //     "Payment complete if a single member is selected or all included members have the same pending payment amount.",
                          //     Colors.redAccent);
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.handshake,
                          color: Colors.white,
                        )))
          ],
        ),
      ),
    );
  }

  AddExpensesButton() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "Add Expenses",
          style: GoogleFonts.notoSans(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.redAccent,
          padding: EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 20,
            right: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
