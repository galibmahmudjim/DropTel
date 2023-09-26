import 'package:droptel/Obj/User.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GuestWidget extends StatefulWidget {
  final double boxheight;
  final double boxwidth;
  final User user;
  final Function(String?, String?) callback;

  const GuestWidget(
      {required this.boxheight,
      required this.boxwidth,
      required this.user,
      required this.callback});

  @override
  State<GuestWidget> createState() => _GuestWidgetState();
}

class _GuestWidgetState extends State<GuestWidget> {
  TextFormField? textFormField = TextFormField();
  String error = "";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String nameError = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(children: [
        Container(
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
              hintText: 'Enter your name',
              hintStyle: TextStyle(
                fontFamily: GoogleFonts.prompt().fontFamily,
                color: Color(0xFFA8A8B3),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                print(value);
                setState(() {
                  nameError = "Name is required";
                });
                return "* Required";
              } else {
                return null;
              }
            },
            onSaved: (val) {},
          ),
        ),
        SizedBox(
          height: widget.boxwidth / 200,
        ),
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
                  nameError = "";
                  error = "";
                });
              } else {
                if (nameError.isNotEmpty) {
                  setState(() {
                    error = nameError;
                  });
                }
              }
            },
            child: Text(
              'Next',
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
