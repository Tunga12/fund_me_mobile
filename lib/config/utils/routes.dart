import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Screens/fundraise_donation_page.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/Screens/signup_page.dart';
import 'package:crowd_funding_app/Screens/splash_screen.dart';
import 'package:crowd_funding_app/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == SplashScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );
    } else if (settings.name == SigninPage.routeName) {
      return MaterialPageRoute(
        builder: (context) => SigninPage(),
      );
    } else if (settings.name == HomePage.routeName) {
      // final donations = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => HomePage(),
      );
    } else if (settings.name == SignupPage.routeName) {
      return MaterialPageRoute(
        builder: (context) => SignupPage(),
      );
    }

    return MaterialPageRoute(
      builder: (context) => SigninPage(),
    );
  }
}
