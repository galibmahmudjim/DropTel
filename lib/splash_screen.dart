import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:droptel/Model/sharedPref.dart';
import 'package:droptel/Pages/homepage.dart';
import 'package:droptel/homeLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import 'Model/Mongodb.dart';
import 'Obj/User.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  Future<Widget> checkLoggedIn() async {
    await Mongodb.connect();
    final String? id = await sharedPref.getID();
    final String? name = await sharedPref.getName();
    if (id != null && name != null) {
      Future<dynamic> res = Mongodb.findUser(id.toString(), name.toString());
      User? user;
      await res.then((value) {
        user = User.fromJson(value);
      });
      if (user != null) {
        print(user!.toJson());
        return HomePage(user: user!);
      } else {
        return HomePageLogin();
      }
    } else {
      return HomePageLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: Image.asset('assets/logo.png'),
      splashIconSize: MediaQuery.of(context).size.height / 5,
      backgroundColor: Color(0xFFFFFFFF),
      pageTransitionType: PageTransitionType.rightToLeft,
      splashTransition: SplashTransition.slideTransition,
      screenFunction: () async {
        return await checkLoggedIn();
      },
    );
  }
}
