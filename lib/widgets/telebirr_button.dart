import 'package:flutter/material.dart';

class TelebirrButton extends StatelessWidget {
  const TelebirrButton({Key? key, required this.onPressed}) : super(key: key);
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 4.0,
      color: Theme.of(context).backgroundColor.withOpacity(0.6),
      child: SizedBox(
        width: size.width,
         height: size.height * 0.1,
        child: TextButton(
          child: Container(
            child: Image.asset("assets/images/telebirr.png",width: size.width * 0.4,),
          ),
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
  }
}
