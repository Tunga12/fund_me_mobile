import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class VerifyButton extends StatelessWidget {
  VerifyButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 50.0,
      width: size.width * 0.6,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor:
                title == "Accept" ? Theme.of(context).accentColor : Colors.red),
        onPressed: () {
          onPressed();
        },
        child: Text(
          '$title',
          style:
              labelTextStyle.copyWith(color: Theme.of(context).backgroundColor),
        ),
      ),
    );
  }
}
