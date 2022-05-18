import 'package:flutter/material.dart';

Future<void> locationShowDialog(
    BuildContext context, Future<void> Function() onPressed) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text('Enable location'),
          content: SingleChildScrollView(
              child: Text(
                  'Legas Fund collects location data to enable the identification of nearby fundraisers')),
          actions: <Widget>[
            TextButton(
              child: Text('DENY'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(child: Text('ACCEPT'), onPressed: onPressed),
          ]);
    },
  );
}
