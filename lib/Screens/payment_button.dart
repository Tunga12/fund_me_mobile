import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  PaymentButton({Key? key, required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 4.0,
      color: Colors.amber,
      child: SizedBox(
        width: size.width,
        child: TextButton(
            onPressed: () {
              onPressed();
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Pay",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.blue[900]),
                ),
                TextSpan(
                  text: "Pal",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.cyan),
                ),
              ]),
            )),
      ),
    );
  }
}
