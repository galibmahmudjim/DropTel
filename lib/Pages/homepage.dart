import 'package:animations/animations.dart';
import 'package:droptel/Widget/SearchWidget.dart';
import 'package:flutter/material.dart';

import '../Widget/SearchBarWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
  bool search = false;

  bool group = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = (MediaQuery.of(context).size.width);
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(),

      //floating action button location to left
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.redAccent,
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 5,
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.print,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: IconButton(
                icon: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Container(
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
                              search = true;
                            }
                          });
                        })
                    : SearchBarWidget(
                        boxheight: height,
                        boxwidth: width,
                        callback: (bool? value) {
                          setState(() {
                            if (value == true) {
                              search = false;
                            }
                          });
                        },
                      )),
          ]),
        ),
      ),
    );
  }

  Widget MyFloatingActionButton() {
    return OpenContainer(
      openElevation: 5.0,
      closedElevation: 0.0,
      transitionType: ContainerTransitionType.fade,
      closedShape: CircleBorder(),
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (BuildContext context, VoidCallback _) {
        return NameEmailForm();
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

  Widget NameEmailForm() {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Hello World'),
      ),
    );
  }
}
