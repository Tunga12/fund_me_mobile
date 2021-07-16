import 'package:flutter/material.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Theme.of(context).backgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.help,
            size: 120.0,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Getting started",
            style: TextStyle(fontSize: 22.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Welcome! learn how to get started on your fundraiser journey here",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
