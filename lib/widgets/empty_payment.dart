import 'package:flutter/material.dart';

class EmptyPymentBody extends StatelessWidget {
  const EmptyPymentBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                  border: Border.all(width: 5.0, color: Colors.green)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.folder_open,
                  color: Colors.green,
                  size: 100.0,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "No payment methods yet",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "If you save a payment method while donating, it will show up here.",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  height: 1.8, color: Theme.of(context).secondaryHeaderColor),
              // textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
