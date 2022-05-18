import 'package:crowd_funding_app/Screens/account_settings.dart';
import 'package:crowd_funding_app/Screens/email_notification.dart';
import 'package:crowd_funding_app/Screens/help.dart';
import 'package:crowd_funding_app/Screens/payment_methods.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/auth.dart';
import 'package:crowd_funding_app/services/provider/category.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/services/provider/notification.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Map<String, dynamic> _languages = {
    "en": "English",
    "am": "አማርኛ",
    'tr': "ትግርኛ",
    'or': "Afan Oromo"
  };

  @override
  void initState() {
    super.initState();
  }

  // String lableLanguage = "en";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.settings_appbar_text.tr(),
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
              title: Text(LocaleKeys.account_listitle_text.tr()),
            ),
            // ListTile(
            //   onTap: () {
            //     print('Payment methods pressed');
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => PaymentMethods()));
            //   },
            //   leading: Icon(Icons.credit_card),
            //   title: Text(LocaleKeys.payment_methods_listitle_text.tr()),
            // ),
            ListTile(
              onTap: () {
                print('Email notifications pressed');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmailNotification()));
              },
              leading: Icon(Icons.email_outlined),
              title: Text(LocaleKeys.email_notificaton_listtile_text.tr()),
            ),
            ListTile(
              onTap: () {
                print('Help pressed');
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Help()));
              },
              leading: Icon(Icons.help_outline_outlined),
              title: Text(LocaleKeys.Help_listtile_text.tr()),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text(LocaleKeys.language_listile_text.tr()),
              trailing: DropdownButton<String>(
                hint: Text(
                  _languages[context.locale.toString()],
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                ),
                onChanged: (value) async {
                  await context.setLocale(Locale(value.toString()));
                },
                items: _languages.entries
                    .map<DropdownMenuItem<String>>((language) {
                  print("value");
                  print(language.key);
                  print(language.value);
                  return DropdownMenuItem<String>(
                    value: language.key,
                    child: Text(language.value),
                  );
                }).toList(),
              ),
            ),
            ListTile(
              onTap: () async {
                print('Sign out pressed');
                loadingProgress(context);
                UserPreference preference = UserPreference();
                await preference.removeToken();
                await preference.removeUser();
                await Provider.of<AuthModel>(context, listen: false).signOut();
                await Provider.of<UserModel>(context, listen: false).signOut();
                await Provider.of<FundraiseModel>(context, listen: false)
                    .signOut();
                await Provider.of<UserNotificationModel>(context, listen: false)
                    .signOut();
                await Provider.of<CategoryModel>(context, listen: false)
                    .signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    SigninPage.routeName, (Route<dynamic> route) => false);
              },
              leading: Icon(Icons.logout),
              title: Text(LocaleKeys.signout_listitle_text.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
