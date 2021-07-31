import 'package:flutter/material.dart';

class WithdrawNote extends StatelessWidget {
  String message;
  WithdrawNote(this.message);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, size: 20.0, color: Theme.of(context).accentColor),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Text(
            "$message",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
