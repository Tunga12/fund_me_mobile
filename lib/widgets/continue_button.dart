import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
    required this.isValidate,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final Function onPressed;
  final bool isValidate;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 45.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isValidate
              ? Theme.of(context).accentColor
              : Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
        ),
        onPressed: () {
          onPressed();
        },
        child: Text(
          "$title",
          style: labelTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            color: isValidate
                ? Theme.of(context).backgroundColor
                : Theme.of(context).secondaryHeaderColor.withOpacity(
                      0.6,
                    ),
          ),
        ),
      ),
    );
  }
}
