import 'package:flutter/material.dart';

class FormProgress extends StatelessWidget {
  const FormProgress({Key? key, required this.size, required this.color})
      : super(key: key);

  final Size size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      width: size.width * 0.24,
      color: color,
    );
  }
}
