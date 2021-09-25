import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class ResponseAlert extends StatelessWidget {
  final String message;
  final ResponseStatus? status;
  final Function? retry;
  ResponseAlert(
    this.message, {
    this.status,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                status == ResponseStatus.CONNECTIONERROR
                    ? Icons.wifi_off_rounded
                    : Icons.error_outline,
                color: Theme.of(context).accentColor,
                size: 70.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "$message",
                style: bodyHeaderTextStyle.copyWith(
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              if (status != null)
                SizedBox(
                  width: size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.5),
                      ),
                    ),
                    onPressed: () {
                      if (retry == null) {
                        return;
                      } else {
                        retry!();
                      }
                    },
                    child: Text(
                      "retry",
                      style: labelTextStyle.copyWith(
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
