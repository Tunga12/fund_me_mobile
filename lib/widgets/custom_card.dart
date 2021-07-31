import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  Widget child;
  Function? onTap;
  CustomCard({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1.0,
                blurRadius: 1.0,
                offset: Offset(0, 3))
          ],
        ),
        padding: EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
