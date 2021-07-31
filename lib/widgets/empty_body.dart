import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:flutter/material.dart';

class EmptyBody extends StatelessWidget {
  final String text1;
  final String text2;
  final String btnText1;
  final bool isFilled;
  final Function onPressed;

  EmptyBody({
    required this.text1,
    required this.text2,
    required this.btnText1,
    required this.isFilled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              "$text1",
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "$text2",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(0.5)),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: isFilled
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                            width: 2.0, color: Theme.of(context).accentColor))),
                onPressed: () {
                  onPressed();
                },
                child: Text(
                  "$btnText1",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isFilled
                          ? Theme.of(context).backgroundColor
                          : Theme.of(context).accentColor),
                ))
          ],
        ),
      ),
    );
  }
}
