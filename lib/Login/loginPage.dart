//write a page for login
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/radioButtonDetails.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final loginForm = 1;
  final signupForm = 2;
  int form = 1;

  double boxheight = 0;
  double boxwidth = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      boxheight = MediaQuery.of(context).size.height / 20;
      boxwidth = MediaQuery.of(context).size.width / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<buttonDetails> buttons = [
      buttonDetails(text: 'Login', index: loginForm, isSelected: false),
      buttonDetails(text: 'Signup', index: signupForm, isSelected: false)
    ];
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.height / 50),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(23)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Text('DROPTEL',
                          style: GoogleFonts.saira(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                letterSpacing: 15),
                          )),
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
