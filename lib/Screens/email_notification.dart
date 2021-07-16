import 'package:flutter/material.dart';

class EmailNotification extends StatefulWidget {
  const EmailNotification({Key? key}) : super(key: key);

  @override
  _EmailNotificationState createState() => _EmailNotificationState();
}

class _EmailNotificationState extends State<EmailNotification> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.9),
      appBar: AppBar(
        title: Text(
          "Email Notifications",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
              onPressed: () {
                final form = _formKey.currentState;

                if (form!.validate()) {
                  print("Saved!");
                }
              },
              child: Text(
                "SAVE",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Theme.of(context).secondaryHeaderColor),
              )),
        ],
      ),
      body: Scrollbar(
        isAlwaysShown: true,
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    color: Colors.white,
                    child: ListTile(
                      leading: Text(
                        "FoFundMe Newsletters",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      trailing: Checkbox(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Email from fundraisers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "You are not getting any emails from any fundraisers yet.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
