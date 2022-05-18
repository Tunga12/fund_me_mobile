import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class ChildUnorderedList extends StatelessWidget {
  ChildUnorderedList({required this.text, this.color});
  final String text;
  final Color? color;

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
                  text: '\u229A    ',
                  style: TextStyle(
                      fontWeight: FontWeight.lerp(
                          FontWeight.w900, FontWeight.w900, 3.0),
                      color: Colors.black)),
              TextSpan(
                  text: "$text",
                  style: bodyTextStyle2.copyWith(
                      fontSize: 16.0,
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
