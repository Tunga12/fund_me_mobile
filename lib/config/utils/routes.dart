import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/Screens/signup_page.dart';
import 'package:crowd_funding_app/Screens/start_page.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    print("routes ${settings.name}");
    if (settings.name == StartPage.routeName) {
      return MaterialPageRoute(
        builder: (context) => StartPage(),
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
