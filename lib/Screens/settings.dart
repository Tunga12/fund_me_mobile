import 'package:crowd_funding_app/Screens/account_settings.dart';
import 'package:crowd_funding_app/Screens/email_notification.dart';
import 'package:crowd_funding_app/Screens/help.dart';
import 'package:crowd_funding_app/Screens/payment_methods.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                print("Account pressed");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountSettings()));
              },
              leading: Icon(Icons.manage_accounts_outlined),
              title: Text("Account"),
            ),
            ListTile(
              onTap: () {
                print('Payment methods pressed');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentMethods()));
              },
              leading: Icon(Icons.credit_card),
              title: Text("Payment methods"),
            ),
            ListTile(
              onTap: () {
                print('Email notifications pressed');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmailNotification()));
              },
              leading: Icon(Icons.email_outlined),
              title: Text("Email notifications"),
            ),
            ListTile(
              onTap: () {
                print('Help pressed');
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Help()));
              },
              leading: Icon(Icons.help_outline_outlined),
              title: Text("Help"),
            ),
            ListTile(
              onTap: () {
                print('Sign out pressed');
              },
              leading: Icon(Icons.logout),
              title: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}
