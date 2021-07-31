import 'package:flutter/material.dart';

Future<void> authShowDialog(BuildContext context, Widget child,
    {bool? error, bool? close = false}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          title: error! ? Text('Error') : null,
          content: SingleChildScrollView(
            child: ListBody(
              children: [child],
            ),
          ),
          actions: close!
              ? <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ]
              : []);
    },
  );
}
