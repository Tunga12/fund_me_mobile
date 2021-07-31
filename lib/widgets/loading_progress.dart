import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:flutter/material.dart';

Future loadingProgress(BuildContext context) {
  return authShowDialog(
      context,
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            width: 20.0,
          ),
          Text("Loading"),
        ],
      ),
      close: false,
      error: false);
}
