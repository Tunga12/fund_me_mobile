import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  UnorderedList({required this.text, this.color});
  String text;
  Color? color;

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
                  style: bodyTextStyle2.copyWith(
                      fontSize: 15.0,
                      color: color != null
                          ? color
                          : Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.6))),
            ],
          ),
        ),
      ),
    );
  }
}
