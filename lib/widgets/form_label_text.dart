import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class FormLabelText extends StatelessWidget {
  final String text;

  FormLabelText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Text(
          "$text",
          style: labelTextStyle.copyWith(
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.6)),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
