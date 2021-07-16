import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  UnorderedList({required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '\u2022    ',
                  style: TextStyle(
                      fontWeight: FontWeight.lerp(
                          FontWeight.w900, FontWeight.w900, 3.0),
                      color: Colors.black)),
              TextSpan(
                  text: "$text",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).accentColor)),
            ],
          ),
        ),
      ),
    );
  }
}
