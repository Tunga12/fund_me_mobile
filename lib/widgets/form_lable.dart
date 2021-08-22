import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  const FormLabel(
    this.title, {
    Key? key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            '$title',
            style: kBodyTextStyle.copyWith(
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
