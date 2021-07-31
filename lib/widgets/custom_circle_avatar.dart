import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  String title;
  CustomCircleAvatar(this.title);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor:
              Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
          child: Text(
            "$title",
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        )
      ],
    );
  }
}
