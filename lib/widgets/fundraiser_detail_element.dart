import 'package:crowd_funding_app/Screens/fundraiser_details.dart';
import 'package:flutter/material.dart';

class FundraiserDetailElements extends StatelessWidget {
  final String title;
  final Widget body;
  final Function? onPressed;

  FundraiserDetailElements(
      {required this.title, required this.body, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed!();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1.0,
                blurRadius: 1.0,
                offset: Offset(0, 3))
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$title", style: titleTextStyle),
            SizedBox(
              height: 20.0,
            ),
            body,
          ],
        ),
      ),
    );
  }
}
