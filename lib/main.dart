import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/constants/colors.dart';
import 'package:crowd_funding_app/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(CrowdFundingApp());
}

class CrowdFundingApp extends StatelessWidget {
  const CrowdFundingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: MaterialColor(0xFF00B860, color),
          accentColor: MaterialColor(0xFF00B860, color),
          indicatorColor: MaterialColor(0xFF08B868, color_two),
          backgroundColor: Colors.white,
          primaryColor: MaterialColor(0xFF00B860, color),
          secondaryHeaderColor: Colors.grey,
          appBarTheme: AppBarTheme(color: Colors.white),
          textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.grey, fontSize: 16.0),
              bodyText2: TextStyle(
                  color: MaterialColor(0xFF08B868, color_two),
                  fontWeight: FontWeight.bold))),
      home: HomePage(),
    );
  }
}
