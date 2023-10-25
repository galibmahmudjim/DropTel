//write a page for login
import 'package:droptel/Login/loginPage.dart';
import 'package:droptel/Signup/Signup.dart';
import 'package:droptel/Widget/guestEntry.dart';
import 'package:droptel/Widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

import '../Constants/radioButtonDetails.dart';
import 'Obj/User.dart';

class HomePageLogin extends StatefulWidget {
  const HomePageLogin({super.key});

  @override
  State<HomePageLogin> createState() => _HomePageLoginState();
}

class _HomePageLoginState extends State<HomePageLogin> {
  final loginForm = 1;
  final signupForm = 2;
  int form = 1;
  bool guestClicked = false;
  bool loginClicked = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool loadingHome = false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    Color colorNotclicked = Color(0xC9C9CC);
    Color colorClicked = Color(0x6CC9C9CC);
    bool googleClicked = false;
    bool facebookClicked = false;

    double boxheight = MediaQuery.of(context).size.height;
    double boxwidth = MediaQuery.of(context).size.width;
    User user = User();

    List<buttonDetails> buttons = [
      buttonDetails(text: 'Login', index: loginForm, isSelected: false),
      buttonDetails(text: 'Signup', index: signupForm, isSelected: false)
    ];
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: boxheight / 20),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: boxwidth,
                            child: Text('DROPTEL',
                                style: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                      letterSpacing: 15),
                                ))),
                        SizedBox(
                          height: boxheight / 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text("Express login via Google and Facebook",
                              style: GoogleFonts.saira(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xD3635353),
                                    letterSpacing: .5),
                              )),
                        ),
                        SizedBox(
                          height: boxheight / 50,
                        ),
                        Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                onTap: () {
                                  setState(() {
                                    googleClicked = true;
                                  });
                                },
                                child: Container(
                                    height: boxheight / 15,
                                    width: boxwidth / 2.5,
                                    decoration: BoxDecoration(
                                        color: Color(0x7EC9C9CC),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Google',
                                          style: GoogleFonts.prompt(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0x8E706B6B),
                                                letterSpacing: .5),
                                          ),
                                        ),
                                        SizedBox(
                                          width: boxwidth / 40,
                                        ),
                                        Container(
                                          height: boxheight / 60,
                                          child: Image.asset(
                                            'assets/signin-google.png',
                                            height: boxheight / 20,
                                            width: boxwidth / 20,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              SizedBox(
                                width: boxwidth / 50,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    facebookClicked = true;
                                  });
                                },
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                child: Container(
                                    height: boxheight / 15,
                                    width: boxwidth / 2.5,
                                    decoration: BoxDecoration(
                                        color: Color(0x7EC9C9CC),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Facebook',
                                          style: GoogleFonts.prompt(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0x8E706B6B),
                                                letterSpacing: .5),
                                          ),
                                        ),
                                        SizedBox(
                                          width: boxwidth / 80,
                                        ),
                                        Container(
                                          height: boxheight / 60,
                                          child: Image.asset(
                                            'assets/signin-facebook.png',
                                            height: boxheight / 20,
                                            width: boxwidth / 20,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: boxheight / 30,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: boxheight / 290,
                          width: boxwidth * 2 / 2.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0x41A8A8B3),
                          ),
                        ),
                        SizedBox(
                          height: boxheight / 30,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.topCenter,
                                    height: boxheight / 20,
                                    width: boxwidth / 1.49,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: boxwidth / 40,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              loginClicked = true;
                                              guestClicked = false;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: boxheight / 20,
                                            width: boxwidth / 6,
                                            decoration: BoxDecoration(
                                                color: guestClicked
                                                    ? colorNotclicked
                                                    : loginClicked
                                                        ? colorClicked
                                                        : colorNotclicked,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10))),
                                            child: Text(
                                              'Login',
                                              style: GoogleFonts.prompt(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF464647),
                                                    letterSpacing: .5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: boxwidth / 30,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              loginClicked = false;
                                              guestClicked = false;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: boxheight / 20,
                                            width: boxwidth / 6,
                                            decoration: BoxDecoration(
                                                color: guestClicked
                                                    ? colorNotclicked
                                                    : !loginClicked
                                                        ? colorClicked
                                                        : colorNotclicked,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10))),
                                            child: Text(
                                              'Signup',
                                              style: GoogleFonts.prompt(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF464647),
                                                    letterSpacing: .5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: boxwidth / 40,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              guestClicked = true;
                                              loginClicked = false;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: boxheight / 20,
                                            width: boxwidth / 6,
                                            decoration: BoxDecoration(
                                                color: guestClicked
                                                    ? colorClicked
                                                    : colorNotclicked,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10))),
                                            child: Text(
                                              'Guest',
                                              style: GoogleFonts.prompt(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF464647),
                                                    letterSpacing: .5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: boxwidth / 30,
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: boxheight / 100000,
                                ),
                                guestClicked
                                    ? GuestWidget(
                                        user: user,
                                        boxheight: boxheight,
                                        boxwidth: boxwidth,
                                        callback: (String? a, String? b) {},
                                      )
                                    : loginClicked
                                        ? LoginWidget(
                                            user: user,
                                            boxheight: boxheight,
                                            boxwidth: boxwidth,
                                            callback: (bool? loading) {
                                              setState(() {
                                                loadingHome = loading!;
                                                initState() {}
                                              });
                                            },
                                          )
                                        : SignupWidget(
                                            user: user,
                                            boxheight: boxheight,
                                            boxwidth: boxwidth,
                                            callback: (bool? loading) {
                                              setState(() {
                                                loadingHome = loading!;
                                                initState() {}
                                              });
                                            },
                                          ),
                                SizedBox(
                                  height: boxheight / 60,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (loadingHome)
            Opacity(
                opacity: 0.6,
                child: loading(
                    heightBox: MediaQuery.of(context).size.height,
                    widthBox: MediaQuery.of(context).size.width)),
        ],
      ),
    );
  }
}
