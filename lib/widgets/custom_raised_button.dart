import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  IconData iconData;
  String title;
  Function onPressed;

  CustomRaisedButton(
      {required this.iconData, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1.0,
                  blurRadius: 1.0,
                  offset: Offset(0, 3))
            ]),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '$title',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
