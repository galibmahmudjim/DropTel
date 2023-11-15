import 'dart:core';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:droptel/Model/Mongodb.dart';
import 'package:droptel/Obj/Activity.dart';
import 'package:droptel/Obj/EventGuest.dart';
import 'package:droptel/Obj/PersonalTransition.dart';
import 'package:droptel/Obj/Statement.dart';
import 'package:droptel/Obj/Wallet.dart';
import 'package:droptel/Obj/eventWallet.dart';
import 'package:droptel/Widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:objectid/objectid.dart';

import '../../Constants/Logger.dart';
import '../../Obj/User.dart';
import '../../Widget/snackbar.dart';

class expenseActivity extends StatefulWidget {
  final eventWallet eventwallet;
  final User user;
  final String id;
  final Activity activity;

  const expenseActivity(
      {Key? key,
      required this.eventwallet,
      required this.user,
      required this.id,
      required this.activity})
      : super(key: key);

  @override
  State<expenseActivity> createState() => _expenseActivityState();
}

class _expenseActivityState extends State<expenseActivity> {
  bool isLoading = false;
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

  // new statement
  List<String> list = <String>['Payment', 'Expenditure'];
  var guestListSelected = [];
  String? dropdownValue;
  int actionSelected = 1;

  // new state end

  TextEditingController statementNameController = TextEditingController();
  TextEditingController amountTextController = TextEditingController();
  TextEditingController customCalculationTitleController =
      TextEditingController();
  TextEditingController operationValueController = TextEditingController();
  int selectedValueOperation = 0;
  String? selectedValueOperationString;
  double totalAmount = 0;
  int memberCount = 0;
  double totalWithPerson = 0;
  double totalAmountPerPerson = 0;
  double valueofOperation = 0;
  double amount = 0;
  bool isReview = false;
  bool isReviewPayment = false;
  bool interlock = false;

  //payment
  double amountPayment = 0;
  double totalAmountPayment = 0;
  int memberCountPayment = 0;
  double totalPerPersonPayment = 0;
  double totalWithPersonPayment = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    if (interlock && actionSelected == 2) {
      isReview = true;
      isReviewPayment = false;
      interlock = false;
    } else if (interlock && actionSelected == 1) {
      isReview = false;
      isReviewPayment = true;
      interlock = false;
    } else {
      isReview = false;
      isReviewPayment = false;
    }
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
            widget.activity.title!,
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
      body: Body(),
    );
  }

  Widget Body() {
    return Container(
      padding: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        color: Colors.indigo[500],
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
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Create new Statement",
                            style: GoogleFonts.notoSans(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ), //title create
                        Container(
                          width: width * 0.9,
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

                        newStatement(),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            isLoading
                ? Opacity(
                    opacity: 0.5,
                    child: loading(
                        heightBox: double.maxFinite,
                        widthBox: double.maxFinite),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget newStatement() {
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
          AddexpensesBottomSheetButtonStatement(),
        ],
      ),
    );
  }

  multiselectGuest() {
    selectGuests.clear();
    selectGuests.add(MultiSelectItem(allGuest, "All"));
    widget.eventwallet.eventGuest!.forEach((element) {
      selectGuests.add(MultiSelectItem(element,
          "${element.name.toString()}  ${element.email!.isEmpty ? "" : "(${element.email.toString()})"}"));
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
                        if (amountTextController.text.isEmpty)
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
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  PaymentAction() {
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
                dividedMemberCheckbox(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (isReviewPayment && actionSelected == 1) reviewPaymentStatement(),
      ],
    );
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
                dividedMemberCheckbox(),
              ],
            ),
          ),
        ),
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
        if (isReview && actionSelected == 2) reviewStatement(),
      ],
    );
  }

  CustomCalculationProperty() {
    return Card(
      elevation: 1,
      color: Colors.indigo[500]?.withOpacity(0.7),
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
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
                    color: Colors.white,
                  ).fontFamily,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  errorStyle: TextStyle(height: 0, fontSize: 0),
                  hintText: 'Title (Ex. VAT, Service Charge)',
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.prompt().fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withOpacity(0.5),
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
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  reviewPaymentStatement() {
    amountPayment = double.parse(amountTextController.text.toString());
    amountPayment = double.parse(amountPayment.toStringAsFixed(2));
    totalAmountPayment = amountPayment;
    memberCountPayment = selectedGuests.length;
    totalPerPersonPayment;
    if (dividedMembers)
      totalPerPersonPayment = amountPayment / memberCountPayment;
    else
      totalPerPersonPayment = amountPayment;
    totalPerPersonPayment =
        double.parse(totalPerPersonPayment.toStringAsFixed(2));
    totalWithPersonPayment = totalPerPersonPayment * memberCountPayment;
    totalWithPersonPayment =
        double.parse(totalWithPersonPayment.toStringAsFixed(2));
    return Card(
        elevation: 1,
        color: Colors.indigo[500]?.withOpacity(0.7),
        child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            padding: EdgeInsets.only(left: 10, right: 10),
            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            width: width,
            child: Container(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: width * 0.25,
                      child: Text(statementNameController.text.toString(),
                          style: GoogleFonts.robotoMono(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Amount",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Container(
                              child: Text(
                                amountPayment.toString(),
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Total",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Container(
                              child: Text(
                                totalAmountPayment.toString(),
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Total Members",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Container(
                              child: Text(
                                memberCountPayment.toString(),
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Total Per Person",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Container(
                              child: Text(
                                totalPerPersonPayment.toString(),
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Total with members",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Container(
                              child: Text(
                                totalWithPersonPayment.toString(),
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            )));
  }

  reviewStatement() {
    logger.d("reviewStatement");
    return Card(
        elevation: 1,
        color: Colors.indigo[500]?.withOpacity(0.7),
        child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            padding: EdgeInsets.only(left: 10, right: 10),
            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            width: width,
            child: Container(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: width * 0.25,
                      child: Text(statementNameController.text.toString(),
                          style: GoogleFonts.robotoMono(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Amount",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Container(
                              child: Text(
                                amount.toString(),
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        if (checkboxValue)
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                child: Text(
                                  customCalculationTitleController.text
                                      .toString(),
                                  style: GoogleFonts.robotoMono(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "${selectedValueOperation == 1 ? "%" : selectedValueOperation == 2 ? "+" : selectedValueOperation == 3 ? "-" : selectedValueOperation == 4 ? "x" : "/"}",
                                      style: GoogleFonts.robotoMono(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      valueofOperation.toString(),
                                      style: GoogleFonts.robotoMono(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Total",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Container(
                              child: Text(
                                totalAmount.toString(),
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Total Members",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Container(
                              child: Text(
                                memberCount.toString(),
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Total Per Person",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Container(
                              child: Text(
                                totalAmountPerPerson.toString(),
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Total with members",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Container(
                              child: Text(
                                totalWithPerson.toString(),
                                style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            )));
  }

  OperationValue() {
    return Container(
        child: TextFormField(
      controller: operationValueController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Value';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        errorStyle: TextStyle(height: 0, fontSize: 0),
        hintText: 'Value',
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.prompt().fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w900,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
      style: TextStyle(
        fontSize: 15,
        fontFamily: GoogleFonts.poppins(
          color: Colors.white,
        ).fontFamily,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w900,
        color: Colors.white,
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

  dropDownMenuCalculation() {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(3)),
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
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
              items: items
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                  .toList(),
              value: selectedValueOperationString,
              onChanged: (String? value) {
                setState(() {
                  selectedValueOperationString = value!;
                  if (value == "Percentage (%)") {
                    selectedValueOperation = 1;
                  } else if (value == "Addition (+)") {
                    selectedValueOperation = 2;
                  } else if (value == "Subtraction (-)") {
                    selectedValueOperation = 3;
                  } else if (value == "Multiplication (x)") {
                    selectedValueOperation = 4;
                  } else if (value == "Division (/)") {
                    selectedValueOperation = 5;
                  }
                });
              },
              dropdownStyleData: DropdownStyleData(
                width: width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.indigo[500],
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
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

  bool dividedMembers = false;

  dividedMemberCheckbox() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Checkbox(
                side: BorderSide(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                ),
                checkColor: Colors.white,
                value: dividedMembers,
                activeColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    dividedMembers = value!;
                  });
                }),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: width * 0.01),
              child: InkWell(
                onTap: () {
                  setState(() {
                    dividedMembers = !dividedMembers;
                  });
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Divide among members?",
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

  bool checkboxValue = false;

  CustomCalculateButton() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Checkbox(
                side: BorderSide(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                ),
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
                  keyboardType: TextInputType.number,
                  controller: amountTextController,
                  onChanged: (value) {
                    if (value.isEmpty && actionSelected == 1) {
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
                      color: Colors.white,
                    ).fontFamily,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
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
                    color: Colors.transparent,
                    child: IconButton(
                        highlightColor: Colors.black,
                        onPressed: () {
                          snackBar(
                              context,
                              "Payment complete if a single member is selected or all included members have the same pending payment amount.",
                              Colors.redAccent);
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

  AddexpensesBottomSheetButtonStatement() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 40),
      child: ElevatedButton(
        onPressed: () {
          if (selectedGuests.isEmpty) {
            snackBar(
                context, "Please select at least one member", Colors.redAccent);
            return;
          }
          if (statementNameController.text.isEmpty) {
            snackBar(context, "Please enter Title", Colors.redAccent);
            return;
          }
          if ((amountTextController.text.isEmpty) && actionSelected == 2) {
            snackBar(context, "Please enter Amount", Colors.redAccent);
            return;
          }

          amount = double.parse(amountTextController.text);
          if (checkboxValue && actionSelected == 2) {
            if (customCalculationTitleController.text.isEmpty) {
              snackBar(context, "Please enter Custom Calculation Title",
                  Colors.redAccent);
              return;
            }

            if (selectedValueOperationString == null &&
                selectedValueOperation == 0) {
              snackBar(context, "Please select Operation", Colors.redAccent);
              return;
            }
            if (operationValueController.text.isEmpty) {
              snackBar(
                  context, "Please enter Operation Value", Colors.redAccent);
              return;
            }
            valueofOperation = double.parse(operationValueController.text);
            if (selectedValueOperation == 1) {
              totalAmount = amount + (amount * valueofOperation / 100);
            } else if (selectedValueOperation == 2) {
              totalAmount = amount + valueofOperation;
            } else if (selectedValueOperation == 3) {
              totalAmount = amount - valueofOperation;
            } else if (selectedValueOperation == 4) {
              totalAmount = amount * valueofOperation;
            } else if (selectedValueOperation == 5) {
              totalAmount = amount / valueofOperation;
            }
          } else {
            totalAmount = amount;
          }
          totalAmount = double.parse(totalAmount.toStringAsFixed(2));
          memberCount = selectedGuests.length;
          if (dividedMembers)
            totalAmountPerPerson = totalAmount / memberCount;
          else
            totalAmountPerPerson = totalAmount;
          totalAmountPerPerson =
              double.parse(totalAmountPerPerson.toStringAsFixed(2));
          totalWithPerson = totalAmountPerPerson * memberCount;
          totalWithPerson = double.parse(totalWithPerson.toStringAsFixed(2));
          if (isReview && actionSelected == 2) {
            processStatement(
                statementNameController.text.toString(),
                customCalculationTitleController.text.toString(),
                amount,
                valueofOperation,
                totalAmount,
                totalAmountPerPerson,
                memberCount);
          } else if (isReviewPayment && actionSelected == 1) {
            ProcessPayment(
              statementNameController.text.toString(),
              amountPayment,
              totalAmountPayment,
              memberCountPayment,
              totalPerPersonPayment,
              totalWithPersonPayment,
            );
          }

          setState(() {
            interlock = true;
          });
        },
        child: Text(
          "${isReview ? "Add Statement" : "Review"}",
          style: GoogleFonts.notoSans(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
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

  void ProcessPayment(
      String string,
      double amountPayment,
      double totalAmountPayment,
      int memberCountPayment,
      double totalPerPersonPayment,
      double totalWithPersonPayment) async {
    List<PersonalTransition> personalTransition = selectedGuests.map((e) {
      return PersonalTransition(
        sId: ObjectId().toString(),
        type: actionSelected == 1 ? "Payment" : "Expenditure",
        member: e,
        amount: totalPerPersonPayment,
      );
    }).toList();
    DateTime now = DateTime.now();
    Statement statement = Statement(
      sId: ObjectId().toString(),
      title: string,
      type: "Statement",
      statementType: actionSelected == 1 ? "Payment" : "Expenditure",
      isCustomOperation: false,
      dateTime: now.toString(),
      operation: null,
      amount: amountPayment,
      operationValue: null,
      total: totalAmount,
      countMembers: memberCount,
      totalPerPerson: totalAmountPerPerson,
      totalWithMembers: totalWithPersonPayment,
      member: personalTransition,
    );
    setState(() {
      isLoading = true;
    });
    var resultWallet = Mongodb.FindEventDetails(widget.eventwallet.sId!);

    Wallet wallet = Wallet();
    String id;
    Activity activity = Activity();

    List<Statement>? stList;
    resultWallet
        ?.then((value) => {
              log_check(),
              if (value != null)
                {
                  wallet = Wallet.fromJson(value),
                  activity = wallet.activityList!
                      .where((element) => element.sId == widget.id)
                      .first as Activity,
                  stList = activity.statements?.map((e) => e).toList(),
                  if (stList == null) stList = [],
                  stList?.add(statement),
                  activity.statements = stList,
                  wallet.activityList
                      ?.removeWhere((element) => element.sId == widget.id),
                  wallet.activityList?.add(activity),
                  logger.d(wallet.toJson()),
                  Mongodb.EventWalletDetails(wallet)?.then((value) => {
                        if (value != null)
                          {
                            setState(() {
                              Navigator.pop(context);
                              isLoading = false;
                              snackBar(context, "Statement Added",
                                  Colors.greenAccent);
                            }),
                          }
                        else
                          {
                            setState(() {
                              isLoading = false;
                            }),
                            snackBar(context, "Something went wrong",
                                Colors.redAccent),
                          }
                      }),
                  setState(() {
                    isLoading = false;
                  }),
                }
            })
        .timeout(Duration(seconds: 10), onTimeout: () {
      setState(() {
        isLoading = false;
      });
      return snackBar(context, "Something went wrong", Colors.redAccent);
    });
  }

  Future<void> processStatement(
      String string,
      String string2,
      double amount,
      double valueofOperation,
      double totalAmount,
      double totalAmountPerPerson,
      int memberCount) async {
    double totalWithMembers = totalAmountPerPerson * memberCount;
    totalWithMembers = double.parse(totalWithMembers.toStringAsFixed(2));
    List<PersonalTransition> personalTransition = selectedGuests.map((e) {
      return PersonalTransition(
        sId: ObjectId().toString(),
        type: actionSelected == 1 ? "Payment" : "Expenditure",
        member: e,
        amount: totalAmountPerPerson,
      );
    }).toList();
    DateTime now = DateTime.now();
    Statement statement = Statement(
      sId: ObjectId().toString(),
      title: string,
      type: "Statement",
      statementType: actionSelected == 1 ? "Payment" : "Expenditure",
      isCustomOperation: checkboxValue,
      dateTime: now.toString(),
      operation: selectedValueOperationString,
      amount: amount,
      CalculationTitle: string2,
      operationValue: valueofOperation,
      total: totalAmount,
      countMembers: memberCount,
      totalPerPerson: totalAmountPerPerson,
      totalWithMembers: totalWithMembers,
      member: personalTransition,
    );

    isLoading = true;
    var resultWallet = Mongodb.FindEventDetails(widget.eventwallet.sId!);

    Wallet wallet = Wallet();
    String id;
    Activity activity = Activity();

    List<Statement>? stList;
    resultWallet
        ?.then((value) => {
              if (value != null)
                {
                  wallet = Wallet.fromJson(value),
                  activity = wallet.activityList!
                      .where((element) => element.sId == widget.id)
                      .first as Activity,
                  stList = activity.statements?.map((e) => e).toList(),
                  if (stList == null) stList = [],
                  stList?.add(statement),
                  activity.statements = stList,
                  wallet.activityList
                      ?.removeWhere((element) => element.sId == widget.id),
                  wallet.activityList?.add(activity),
                  logger.d(wallet.toJson()),
                  Mongodb.EventWalletDetails(wallet)?.then((value) => {
                        if (value != null)
                          {
                            setState(() {
                              Navigator.pop(context);
                              isLoading = false;
                              snackBar(context, "Statement Added",
                                  Colors.greenAccent);
                            }),
                          }
                        else
                          {
                            setState(() {
                              isLoading = false;
                            }),
                            snackBar(context, "Something went wrong",
                                Colors.redAccent),
                          }
                      }),
                  setState(() {
                    isLoading = false;
                  }),
                }
            })
        .timeout(Duration(seconds: 10), onTimeout: () {
      setState(() {
        isLoading = false;
      });
      return snackBar(context, "Something went wrong", Colors.redAccent);
    });
  }
}
