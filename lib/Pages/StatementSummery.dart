import 'package:droptel/Obj/PersonalTransition.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Obj/Statement.dart';
import '../Obj/User.dart';

class StatementSummery extends StatefulWidget {
  final User user;
  final Statement statement;

  const StatementSummery(
      {super.key, required this.user, required this.statement});

  @override
  State<StatementSummery> createState() => _StatementSummeryState();
}

class _StatementSummeryState extends State<StatementSummery> {
  @override
  double height = 0;
  double width = 0;
  Statement statement = Statement();
  Widget build(BuildContext context) {
    statement = widget.statement;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    ));
  }

  Body() {
    DateTime date = DateTime.parse(statement.dateTime!);
    DateFormat formatter = DateFormat('hh-mm aa\ndd-MMM-yyyy');
    String formatted = formatter.format(date);
    return Container(
      height: height,
      width: width,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.12,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 30),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              statement.title!,
                              style: GoogleFonts.inter(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 30),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              formatted,
                              style: GoogleFonts.poppins(
                                  color: Colors.black26,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.12,
                        ),
                        Container(
                          child: Text(
                            "Total Expense",
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
                            "৳ ${statement.totalWithMembers.toString()}",
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
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromRGBO(66, 34, 74, 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "${statement.statementType == "Payment" ? "Payment" : "Expenditure"}",
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
                          "৳ ${statement.amount.toString()}",
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (statement.isCustomOperation == true)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Text(
                                statement.calculationTitle!,
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
                                "৳ ${statement.operationValue.toString()} ${statement.operation == "Percentage (%)" ? "%" : statement.operation == "Addition (+)" ? "+" : statement.operation == "Subtraction (-)" ? "-" : statement.operation == "Multiplication (x)" ? "x" : "/"}",
                                style: GoogleFonts.workSans(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          "Subtotal",
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
                          "৳ ${statement.total.toString()}",
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
                          "Total Per Person",
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
                          "৳ ${statement.totalPerPerson.toString()}",
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
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
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Included ${statement.countMembers} Person",
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
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            color: Colors.transparent,
            height: height * 0.05,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  memberList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 20, bottom: height * 0.4),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: statement.members!.length,
      itemBuilder: (BuildContext context, int index) {
        return makeListTile(statement.members[index]);
      },
    );
  }

  makeListTile(PersonalTransition? member) {
    return Card(
        elevation: 0.2,
        child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(int.parse(member!.member!.color!))
                          .withOpacity(0.8)),
                  child: Center(
                    child: Text(
                      member!.member!.name![0],
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        member.member!.name!,
                        style: GoogleFonts.inter(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (member.member!.email != "")
                      SizedBox(
                        height: 5,
                      ),
                    Container(
                      child: Text(
                        member.member!.email!,
                        style: GoogleFonts.inter(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  child: Text(
                    "৳ ${member.amount}",
                    style: GoogleFonts.inter(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )));
  }
}
