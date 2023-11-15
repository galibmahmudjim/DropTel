import 'package:droptel/Obj/EventGuest.dart';
import 'package:droptel/Obj/Statement.dart';
import 'package:droptel/Util/ExpenseCalculate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Obj/Activity.dart';
import '../Obj/User.dart';
import '../Obj/Wallet.dart';
import '../Util/AllTransactions.dart';
import 'ActivityStatementSummery.dart';

class IndividualSummery extends StatefulWidget {
  final User user;
  final Wallet wallet;
  final Activity activity;
  final EventGuest eventGuest;
  const IndividualSummery(
      {super.key,
      required this.user,
      required this.wallet,
      required this.activity,
      required this.eventGuest});

  @override
  State<IndividualSummery> createState() => _IndividualSummeryState();
}

class _IndividualSummeryState extends State<IndividualSummery> {
  User user = User();
  Wallet wallet = Wallet();
  Activity activity = Activity();
  EventGuest eventGuest = EventGuest();
  double height = 0;
  double width = 0;
  double total = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    user = widget.user;
    wallet = widget.wallet;
    activity = widget.activity;
    eventGuest = widget.eventGuest;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Body(),
      appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7)),
          title: Text(
            activity.title!,
            style: GoogleFonts.lato(
                color: Colors.black.withOpacity(0.8),
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
    ));
  }

  Body() {
    // DateTime date = DateTime.parse(statement.dateTime!);
    // DateFormat formatter = DateFormat('hh-mm aa\ndd-MMM-yyyy');
    // String formatted = formatter.format(date);
    return Container(
      height: height,
      width: width,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 30),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              eventGuest.name!,
                              style: GoogleFonts.inter(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 30),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              eventGuest.email?.toString() ?? "",
                              style: GoogleFonts.poppins(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ]),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Text(
                            "Due Expense",
                            style: GoogleFonts.workSans(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            "৳ ${ActivityIndividualDue(activity, eventGuest.index!)}",
                            style: GoogleFonts.workSans(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
                Container(
                  width: width,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromRGBO(66, 34, 74, 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Expenditure",
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          "৳ ${ActivityIndividualExpense(activity, eventGuest.index!)}",
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          "Payment",
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          "৳ ${ActivityIndividualPayment(activity, eventGuest.index!)}",
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Statement Transactions",
                          style: GoogleFonts.inter(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      memberList(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  memberList() {
    List<Statement> statements =
        FindAllActivityIndividualTransaction(activity, eventGuest.index!);
    statements.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 20, bottom: height * 0.4),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: statements.length,
      itemBuilder: (BuildContext context, int index) {
        // return Container();
        return makeListTile(statements[index]);
      },
    );
  }

  makeListTile(Statement? statement) {
    DateTime date = DateTime.parse(statement?.dateTime! ?? "");
    DateFormat formatter = DateFormat('hh:mm aa\ndd-MMM-yyyy');
    String formatted = formatter.format(date);
    return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: statement?.type == "Activity"
            ? Colors.lightBlueAccent
            : (statement as Statement).statementType == "Payment"
                ? Colors.lime
                : Colors.green,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ActivityStatementSummery(
                user: user,
                statement: statement,
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
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(statement?.title ?? "Title",
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
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                        "${(statement as Statement).statementType == "Payment" ? "Payemnt" : "Expenditure"}: ",
                                        style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    Expanded(
                                        child: Text(
                                            statement.totalPerPerson.toString(),
                                            textAlign: TextAlign.end,
                                            style: GoogleFonts.robotoMono(
                                                color: Colors.white,
                                                fontSize: 17,
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
