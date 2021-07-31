import 'package:crowd_funding_app/Screens/popular_fundraise_detail.dart';
import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  String leadingTitle;
  String trailingTitle;
  TitleRow({required this.leadingTitle, required this.trailingTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$leadingTitle",
          style: titleTextStyle,
        ),
        Container(
          padding: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            "$trailingTitle",
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
        )
      ],
    );
  }
}
