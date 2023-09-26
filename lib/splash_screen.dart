import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:droptel/homeLogin.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/logo.png'),
      splashIconSize: MediaQuery.of(context).size.height / 5,
      nextScreen: HomePageLogin(),
      backgroundColor: Color(0xFFFFFFFF),
      pageTransitionType: PageTransitionType.rightToLeft,
      splashTransition: SplashTransition.slideTransition,
      animationDuration: const Duration(milliseconds: 2000),
    );
    ;
  }
}
