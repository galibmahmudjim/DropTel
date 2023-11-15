import 'package:droptel/Constants/Logger.dart';
import 'package:droptel/Model/Mongodb.dart';
import 'package:droptel/Obj/Activity.dart';
import 'package:droptel/Obj/ActivityList.dart';
import 'package:droptel/Obj/Wallet.dart';
import 'package:droptel/Obj/eventWallet.dart';
import 'package:droptel/Pages/ActivityStatementSummery.dart';
import 'package:droptel/Pages/ActivitySummery.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Obj/Statement.dart';
import '../Obj/User.dart';
import '../Widget/loading.dart';
import 'expenseActivity.dart';
import 'expenses.dart';

class ActivityStatementList extends StatefulWidget {
  final Wallet wallet;
  final eventWallet event;
  final User user;
  final String activityID;
  const ActivityStatementList({
    required this.wallet,
    required this.event,
    required this.user,
    required this.activityID,
  });

  @override
  State<ActivityStatementList> createState() => _ActivityStatementListState();
}

class _ActivityStatementListState extends State<ActivityStatementList> {
  Wallet wallet = Wallet();
  eventWallet event = eventWallet();
  User user = User();
  Activity activity = Activity();

  bool isLoading = false;
  getAllData() async {
    isLoading = true;
    Future<dynamic>? data = Mongodb.FindEventDetails(event.sId!);

    data?.then((value) => {
          setState(() {
            wallet = Wallet.fromJson(value);
            activity = wallet.activityList!.where((element) {
              return element.sId == widget.activityID;
            }).first as Activity;
            isLoading = false;
          })
        });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    event = widget.event;
    user = widget.user;
    isLoading = true;
    getAllData();
  }

  final List<String> sortList = [
    "Both",
    "Activity",
    "Payment",
    "Expenditure",
  ];
  String sortValue = "Both";
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
            return expenseActivity(
              activity: activity,
              eventwallet: event,
              user: user,
              id: widget.activityID,
            );
          }));
          setState(() {});
        },
        label: Text(
          "Add Statement",
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ActivitySummery(
                      user: user,
                      activity: activity,
                      wallet: wallet,
                      event: event,
                    );
                  }));
                },
                icon: Icon(
                  Icons.summarize,
                  color: Colors.black.withOpacity(0.7),
                )),
            PopupMenuButton(
                onSelected: (value) {
                  loggerPrint(value);
                  setState(() {
                    sortValue = value.toString();
                  });
                },
                icon: Icon(
                  Icons.sort,
                  color: Colors.black.withOpacity(0.7),
                ),
                itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: Text("Both"),
                        value: sortList[0],
                      ),
                      PopupMenuItem(
                        child: Text(sortList[1]),
                        value: sortList[1],
                      ),
                      PopupMenuItem(
                        child: Text(sortList[2]),
                        value: sortList[2],
                      ),
                      PopupMenuItem(
                        child: Text(sortList[3]),
                        value: sortList[3],
                      ),
                    ]),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return expenses(
                      eventwallet: event,
                      user: user,
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
            activity.title ?? "Event",
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
              setState(() {
                isLoading = true;
              });
              await getAllData();
            },
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return activityListView();
                  },
                ),
              )
            ]))));
  }

  FilterSection() {
    if (sortValue != "Both")
      return Container(
        padding: EdgeInsets.only(
          left: 30,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Filter: ",
              style: GoogleFonts.robotoSlab(
                  fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              sortValue,
              style: GoogleFonts.robotoSlab(
                  fontSize: 15, fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    sortValue = "Both";
                  });
                },
                icon: Icon(
                  Icons.close,
                  size: 20,
                ))
          ],
        ),
      );
    else
      return Container();
  }

  activityListView() {
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
                  future: Mongodb.FindEventDetails(event.sId!)!,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return loading(
                          heightBox: double.maxFinite,
                          widthBox: double.maxFinite);
                    } else if (snapshot.hasError) {
                      isLoading = false;

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
                          'No Statement Found',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                        ));
                      } else {
                        wallet = Wallet.fromJson(data);
                        activity = wallet.activityList!.where((element) {
                          return element.sId == widget.activityID;
                        }).first as Activity;
                        if (activity.statements?.length == 0 ||
                            activity.statements == null) {
                          return Center(
                              child: Text(
                            'No Activity Found',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ));
                        }
                      }
                      return NotificationListener<
                          OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                        child: ListView.builder(
                          padding:
                              EdgeInsets.only(top: 0, bottom: height * 0.4),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: activity.statements!.where((element) {
                                return element.statementType == sortValue ||
                                    sortValue == "Both";
                              }).length +
                              1,
                          itemBuilder: (BuildContext context, int index) {
                            activity.statements?.sort(
                                (a, b) => b.dateTime!.compareTo(a.dateTime!));
                            List<Statement> statements =
                                activity.statements!.where((element) {
                              return element.statementType == sortValue ||
                                  sortValue == "Both";
                            }).toList();
                            return index == 0
                                ? FilterSection()
                                : makeListTile(statements[index - 1]);
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
    DateTime dateTime = DateTime.parse(items.dateTime!);
    DateFormat formatter = DateFormat('hh:mm aa\ndd-MMM-yyyy');
    String formatted = formatter.format(dateTime);
    return CardStatement(items, formatted);
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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ActivityStatementSummery(
                user: user,
                statement: items,
                title: activity.title!,
              );
            }));
            setState(() {});
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
                                  Text(formatted,
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
                                        "${(items).statementType == "Payment" ? (items.amount!).toString() : items.amount.toString()}",
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                            if ((items).statementType == "Expenditure" &&
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
                            if ((items).statementType == "Expenditure")
                              Row(
                                children: [
                                  Text("Subtotal: ",
                                      style: GoogleFonts.robotoMono(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                      child: Text((items).total.toString(),
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
                                    child: Text((items).countMembers.toString(),
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
                                        "${(items).statementType == "Payment" ? (items.totalWithMembers!).toString() : items.totalWithMembers.toString()}",
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
}
