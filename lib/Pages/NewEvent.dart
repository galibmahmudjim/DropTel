import 'package:droptel/Pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({super.key});

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

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  double height = 0;
  double width = 0;
  int typeIndex = 0;

  final PanelController _panelController = PanelController();

  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Test',
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: Text('Test'),
  //       ),
  //       body: SlidingUpPanel(
  //         controller: _panelController,
  //         panelBuilder: _buildListView,
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildListView(ScrollController scrollController) {
  //   return ListView.builder(
  //     controller: scrollController,
  //     itemCount: 100,
  //     itemBuilder: (context, index) {
  //       return Builder(
  //         builder: (context) {
  //           return Focus(
  //             onFocusChange: (value) {
  //               if (value) {
  //                 if (!_panelController.isPanelOpen) {
  //                   _panelController.open();
  //                 }
  //
  //                 // Experimented with programmatic scrolling:
  //                 //
  //                 //     // Scroll, so the focused widget is always vertically centered
  //                 //     scrollController.position.ensureVisible(
  //                 //       context.findRenderObject()!,
  //                 //       alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
  //                 //       alignment: 0.5,
  //                 //       curve: Curves.ease,
  //                 //       duration: const Duration(milliseconds: 300),
  //                 //     );
  //                 //
  //               }
  //             },
  //             child: Container(
  //               margin: const EdgeInsets.all(10),
  //               child: Builder(
  //                 builder: (context) {
  //                   return Text(
  //                     (Focus.of(context).hasFocus ? 'Focused' : 'Unfocused') +
  //                         ' - $index',
  //                   );
  //                 },
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
// }
  @override
  Widget build(BuildContext context) {
    EventEmail.text = "galibmahmudjim@gmail.com";
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
          body: HomePage(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
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
                                      value1.hour.toString() +
                                      ":" +
                                      value1.minute.toString() +
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

  Widget SlideWidget(ScrollController scrollController) {
    List<String> items = List.generate(100, (index) => 'Item $index');

    return Container(
      child: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
            child: Column(
              children: [
                Padding(
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
                      IconButton(onPressed: () {}, icon: Icon(Icons.check))
                    ],
                  ),
                ),
                Form(
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
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: height * 0.1,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 1, color: Color(0x73706B6B)),
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
                                    child: Opacity(
                                        opacity: 0.5,
                                        child: Icon(Icons.people)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        onPressed: () {},
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
                        ), //AddPeople
                        // ListView.builder(
                        //   controller: scrollController,
                        //   itemCount: 100,
                        //   itemBuilder: (context, index) {
                        //     return Builder(
                        //       builder: (context) {
                        //         return Focus(
                        //           onFocusChange: (value) {
                        //             if (value) {
                        //               if (!_panelController.isPanelOpen) {
                        //                 _panelController.open();
                        //               }
                        //             }
                        //           },
                        //           child: Container(
                        //             margin: const EdgeInsets.all(10),
                        //             child: Builder(
                        //               builder: (context) {
                        //                 return Text(
                        //                   (Focus.of(context).hasFocus
                        //                           ? 'Focused'
                        //                           : 'Unfocused') +
                        //                       ' - $index',
                        //                 );
                        //               },
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     );
                        //   },
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
