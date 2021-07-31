import 'package:crowd_funding_app/Screens/popular_fundraise_detail.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class ResponseAlert extends StatelessWidget {
  final String message;
  ResponseAlert(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                color: Theme.of(context).accentColor,
                size: 70.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "$message",
                style: bodyHeaderTextStyle.copyWith(
                  color: Theme.of(context).accentColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
