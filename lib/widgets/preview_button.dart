import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class PreviewButton extends StatelessWidget {
  final Function onPressed;
  bool isActive;

  PreviewButton({required this.isActive, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 45.0,
      child: TextButton(
          onPressed: () {
            onPressed();
          },
          child: Text(
            'Preview fundraiser',
            style: bodyTextStyle.copyWith(
              color: isActive
                  ? Theme.of(context).accentColor
                  : Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
            ),
          ),
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
                width: 1.5,
                color: isActive
                    ? Theme.of(context).accentColor
                    : Theme.of(context).secondaryHeaderColor.withOpacity(0.3)),
          ))),
    );
  }
}
