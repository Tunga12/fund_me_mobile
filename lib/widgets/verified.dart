import 'package:flutter/material.dart';

class Verfied extends StatelessWidget {
  const Verfied({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue,
      ),
      child: Center(
        child: Icon(
          Icons.check,
          size: 15,
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}
