import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class PreviewTextButton extends StatelessWidget {
  const PreviewTextButton(
      {Key? key,
      required this.onPressed,
      required this.leadingChild,
      required this.backgroundColor,
      required this.title})
      : super(key: key);

  final Widget leadingChild;
  final Function onPressed;
  final Color backgroundColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 50.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
            side: BorderSide(
              width: 1.5,
              color: backgroundColor.withAlpha(200),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            leadingChild,
            Expanded(
              child: Center(
                child: Text(
                  "$title",
                  style: bodyTextStyle.copyWith(
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
                  ),
                ),
              ),
            )
          ],
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
