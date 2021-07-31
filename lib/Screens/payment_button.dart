import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({Key? key, required this.size, required this.onPressed})
      : super(key: key);

  final Size size;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
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
