import 'package:droptel/Obj/User.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  final double boxheight;
  final double boxwidth;
  final User user;
  final Function(String?, String?) callback;

  const LoginWidget(
      {required this.boxheight,
      required this.boxwidth,
      required this.user,
      required this.callback});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextFormField? textFormField = TextFormField();
  String error = "";
  bool passwordVisible = false;
  GlobalKey<FormState> formkeyPassword = GlobalKey<FormState>();
  GlobalKey<FormState> formkeyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String emailError = "";
  String passwordError = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(children: [
        Container(
          key: formkeyEmail,
          alignment: Alignment.centerLeft,
          height: widget.boxheight / 15,
          width: widget.boxwidth * 2 / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            color: Color(0x41A8A8B3),
          ),
          child: TextFormField(
            cursorColor: Colors.black,
            style: TextStyle(
              fontSize: 16,
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
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              hintText: 'Enter your email',
              hintStyle: TextStyle(
                fontFamily: GoogleFonts.prompt().fontFamily,
                color: Color(0xFFA8A8B3),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            validator: (value) {
              if (value == null) {
                print(value);
                return "Enter valid email";
              } else if (value!.isEmpty) {
                print(value);
                setState(() {
                  emailError = "Email is required";
                });
                return "* Required";
              } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$",
                      caseSensitive: false, multiLine: false)
                  .hasMatch(value)) {
                setState(() {
                  emailError = "Enter valid email";
                });
                return "Enter valid email";
              } else {
                return null;
              }
            },
            onChanged: (val) {},
          ),
        ),
        SizedBox(
          height: widget.boxwidth / 200,
        ),
        Container(
            key: formkeyPassword,
            alignment: Alignment.center,
            height: widget.boxheight / 15,
            width: widget.boxwidth * 2 / 2.5,
            decoration: BoxDecoration(
              color: Color(0x41A8A8B3),
            ),
            child: TextFormField(
              cursorColor: Colors.black,
              style: TextStyle(
                fontSize: 16,
                fontFamily: GoogleFonts.prompt(
                  letterSpacing: 1,
                  color: Color(0xFF464647),
                ).fontFamily,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Color(0xFF464647),
              ),
              obscureText: !passwordVisible,
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                errorStyle: TextStyle(
                    height: 0, color: Colors.transparent, fontSize: 0),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: 'Enter secure password',
                hintStyle: TextStyle(
                  fontFamily: GoogleFonts.prompt().fontFamily,
                  color: Color(0xFFA8A8B3),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: IconButton(
                  icon: !passwordVisible
                      ? Icon(
                          Icons.visibility_off,
                          color: Color(0xFFA8A8B3),
                        )
                      : Icon(
                          Icons.visibility,
                          color: Color(0xFFA8A8B3),
                        ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null) {
                  print(value);
                  return "Enter valid password";
                } else if (value!.isEmpty) {
                  setState(() {
                    passwordError = "Password is required";
                  });
                  return "* Required";
                } else if (value.length < 6) {
                  setState(() {
                    passwordError = "Password should be atleast 6 characters";
                  });
                  return "Password should be atleast 6 characters";
                } else if (value.length > 15) {
                  setState(() {
                    passwordError =
                        "Password should not be greater than 15 characters";
                  });
                  return "Password should not be greater than 15 characters";
                } else
                  return null;
              },
              onSaved: (val) {},
            )),
        SizedBox(
          height: widget.boxwidth / 200,
        ),
        //submit button
        Container(
          height: widget.boxheight / 15,
          width: widget.boxwidth * 2 / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
            color: Color(0xFF111112),
          ),
          child: TextButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                setState(() {
                  emailError = "";
                  passwordError = "";
                  error = "";
                });
              } else {
                if (emailError.isNotEmpty) {
                  setState(() {
                    passwordError = "";
                    error = emailError;
                  });
                } else if (passwordError.isNotEmpty) {
                  setState(() {
                    emailError = "";
                    error = passwordError;
                  });
                }
              }
            },
            child: Text(
              'Log in',
              style: TextStyle(
                fontFamily: GoogleFonts.prompt().fontFamily,
                color: Color(0xFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SizedBox(
          height: widget.boxwidth / 1000,
        ),
        Container(
          height: widget.boxheight / 15,
          width: widget.boxwidth * 2 / 2.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
            color: Color(0x111112),
          ),
          child: Text(
            error.toString(),
            style: TextStyle(
              fontFamily: GoogleFonts.prompt().fontFamily,
              color: Colors.red,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ]),
    );
  }
}