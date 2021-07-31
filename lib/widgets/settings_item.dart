import 'package:flutter/material.dart';

class FundraiseSettingItem extends StatelessWidget {
  String title;

  FundraiseSettingItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$title',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Switch.adaptive(value: true, onChanged: (value) {}),
        ],
      ),
    );
  }
}
