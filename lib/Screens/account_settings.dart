import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Account settings",
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
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    // spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ],
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "General settings",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).secondaryHeaderColor),
                      )
                    ],
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "First name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "First name must not empty";
                            }
                          },
                          onSaved: (value) {},
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Last name"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Last name must not empty";
                            }
                          },
                          onSaved: (value) {},
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Email"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email must not empty";
                            }
                          },
                          onSaved: (value) {},
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Password"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password must not empty";
                            }
                          },
                          onSaved: (value) {},
                        ),
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Connected accounts",
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Connecting makes it easy for you to share",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.facebook,
                      color: Colors.blue,
                      size: 35.0,
                    ),
                    Text(
                      "Facebook",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            side: BorderSide(color: Colors.green, width: 1.5)),
                        onPressed: () {},
                        child: Text("Connect"))
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deleting your account will remove all of your activity and campaigns, and you will no longer be able to sign in with this account.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(height: 1.8),
                ),
                TextButton(
                  child: Text(
                    "Delete account",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.deepOrangeAccent.shade200),
                  ),
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 0.0)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
