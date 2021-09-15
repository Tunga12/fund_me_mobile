import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/beneficiary_continue.dart';
import 'package:crowd_funding_app/Screens/forgot_password.dart';
import 'package:crowd_funding_app/Screens/popular_fundraise_detail.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/Screens/splash_screen.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/team_add_deep_link.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  StartPage({Key? key}) : super(key: key);
  static String routeName = '/';

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String? _token;
  User? _user;
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () async => await getUserInformation(),
    );
  }

  getUserInformation() async {
    UserPreference _userPreference = UserPreference();
    PreferenceData _preferenceData = await _userPreference.getUserToken();
    PreferenceData _userPreferenceData =
        await _userPreference.getUserInfromation();
    setState(() {
      _token = _preferenceData.data;
      _user = _userPreferenceData.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("starting page rendering");
    final _model = context.read<TeamAddModel>();
    return StreamBuilder<String>(
      stream: _model.state,
      builder: (context, snapshots) {
        print("snapshots ${snapshots.data}");
        if (!snapshots.hasData) {
          print('snapshots has no data');
          return SplashScreen();
        } else {
          String data = snapshots.data!;
          print('snapshots has data');

          if (data.substring(26).startsWith('fundraiser')) {
            String fundraiserId = data.substring(37);
            return CampaignDetail(id: fundraiserId);
          } else if (data.substring(26).startsWith("verify")) {
            String userId = data.substring(33);
            return ForgotPassword(url: userId);
          } else if (data.substring(26).startsWith('accept?fundraiser')) {
            print("Updating fundraiser");
            String fundraiserId = data.substring(44, 68);
            String beneficiaryId = data.substring(81, 105);
            print(beneficiaryId);
            print(fundraiserId);

            if (_token != null) {
              return BeneficiaryContinue(
                _token!,
                fundraiserId + ":" + beneficiaryId,
                _user!,
              );
            }

            return SigninPage(
              url: fundraiserId + ":" + beneficiaryId,
            );

            // return Container();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
                centerTitle: true,
              ),
              body: Container(
                child: Center(
                  child: Text("Undefined path"),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
