import 'package:faculty/Feature/Screen/Auth/Login.dart';
import 'package:faculty/Feature/Screen/Auth/Signup.dart';
import 'package:faculty/Feature/Screen/OverScreen/Home/Widget/MainScreen.dart';
import 'package:faculty/SplashScreen.dart';
import 'package:faculty/Widget/Additional/CustomHiddenbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

Route<dynamic> onGenerator(RouteSettings settings){
  switch(settings.name){
    case Login.route:
      return PageTransition(
        child: const Login(), 
        type: PageTransitionType.fade
      );
    case SignUp.route:
      return PageTransition(
        child: const SignUp(), 
        type: PageTransitionType.fade
      );
    case HiddenDrawer.route:
      return PageTransition(
        child: const HiddenDrawer(), 
        type: PageTransitionType.fade
      );
    case SplashScreen.route:
      return PageTransition(
        child: const SplashScreen(), 
        type: PageTransitionType.fade
      );
    case MainScreen.route:
      return PageTransition(
        child: const SplashScreen(), 
        type: PageTransitionType.fade
      );
    default:
      return PageTransition(
        child: Scaffold(
          body: Center(
            child: Text(
              "404 Page Not Found",
              style: GoogleFonts.merriweather(
                fontSize: 25
              ),
            ),
          ),
        ), 
        type: PageTransitionType.fade
      );
  }
}