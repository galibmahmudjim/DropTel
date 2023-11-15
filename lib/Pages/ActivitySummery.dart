import 'package:droptel/Obj/Activity.dart';
import 'package:droptel/Obj/EventGuest.dart';
import 'package:droptel/Obj/eventWallet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Obj/User.dart';
import '../Obj/Wallet.dart';
import '../Util/ExpenseCalculate.dart';
import 'ActivityIndividualSummery.dart';

class ActivitySummery extends StatefulWidget {
  final User user;
  final Activity activity;
  final Wallet wallet;
  final eventWallet event;

  const ActivitySummery(
      {super.key,
      required this.user,
      required this.activity,
      required this.wallet,
      required this.event});

  @override
  State<ActivitySummery> createState() => _ActivitySummeryState();
}

class _ActivitySummeryState extends State<ActivitySummery> {
  double height = 0;
  double width = 0;
  double total = 0;

  User user = User();
  Activity activity = Activity();
  Wallet wallet = Wallet();
  eventWallet event = eventWallet();
  @override
  Widget build(BuildContext context) {
    user = widget.user;
    event = widget.event;
    wallet = widget.wallet;
    activity = widget.activity;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
      appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7)),
          title: Text(
            event.title!,
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
    DateTime date = DateTime.parse(activity.dateTime!);
    DateFormat formatter = DateFormat('hh-mm aa\ndd-MMM-yyyy');
    String formatted = formatter.format(date);
    var expenditure = ActivityExpense(activity);
    var paid = ActivityPayment(activity);
    total = ActivityDueExpense(activity);

    var countMembers = event.eventGuest?.length;
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
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 30),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              activity.title!,
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
                        SizedBox(),
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
                            "৳ ${total.toString()}",
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
                          "৳ ${expenditure.toString()}",
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
                          "Paid",
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
                          "৳ ${paid.toString()}",
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
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Included ${countMembers} Person",
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
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 20, bottom: height * 0.4),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: event.eventGuest?.length,
      itemBuilder: (BuildContext context, int index) {
        return makeListTile(event.eventGuest?[index]);
      },
    );
  }

  makeListTile(EventGuest? member) {
    return Card(
        margin: EdgeInsets.only(bottom: 10, right: 10),
        elevation: 0.2,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return IndividualSummery(
                activity: activity,
                user: user,
                wallet: wallet,
                eventGuest: member,
              );
            }));
          },
          child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(int.parse(member!.color!))
                                  .withOpacity(0.8)),
                          child: Center(
                            child: Text(
                              member.name![0],
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
                                member.name!,
                                style: GoogleFonts.inter(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Due Expense: ",
                                style: GoogleFonts.robotoMono(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                "৳ ${ActivityIndividualDue(activity, member.index!).toString()}",
                                style: GoogleFonts.robotoMono(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
