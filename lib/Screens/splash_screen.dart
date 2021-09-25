import 'dart:async';

import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
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
        Duration(milliseconds: 100),
        () => user!.status
            ? Navigator.of(context, rootNavigator: false)
                .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false)
            : Navigator.of(context, rootNavigator: false)
                .pushNamedAndRemoveUntil(
                    WelcomePage.routeName, (route) => false),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getUser() async {
    UserPreference userPreference = UserPreference();
    final _loggedUser = await userPreference.getUserInfromation();
    // final _loggedUser = PreferenceData(data: User(), status: false);
    if (mounted)
      setState(() {
        user = _loggedUser;
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/logo_image.PNG',
                  width: size.width * 0.6),
            ),
          ],
        ),
      ),
    );
  }
}
