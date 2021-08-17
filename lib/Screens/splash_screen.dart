import 'dart:async';

import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/Screens/welcom_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PreferenceData? user;

  @override
  void initState() {
    super.initState();
    getUser().whenComplete(() async {
      Timer(
        Duration(seconds: 2),
        () => user!.status
            ? Navigator.of(context)
                .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false)
            : Navigator.of(context).pushNamedAndRemoveUntil(
              WelcomePage.routeName, (route) => false),
      );
    });
  }

  Future getUser() async {
    UserPreference userPreference = UserPreference();
    final loggedUser = await userPreference.getUserInfromation();

    setState(() {
      user = loggedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("start Page");
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Center(
            child: Image.asset('assets/images/gofundme.png',
                width: size.width * 0.6)),
      ),
    );
  }
}
