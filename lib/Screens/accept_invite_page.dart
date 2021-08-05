import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/actions.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/team_add_deep_link.dart';
import 'package:crowd_funding_app/services/provider/team_member.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:crowd_funding_app/widgets/verify_invitation_button.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AcceptTeamInvitation extends StatefulWidget {
  AcceptTeamInvitation({Key? key, required this.data}) : super(key: key);
  final String data;

  @override
  AcceptTeamInvitationState createState() => AcceptTeamInvitationState();
}

class AcceptTeamInvitationState extends State<AcceptTeamInvitation> {
  User? user;
  String? token;

  getInformations() async {
    UserPreference userPreference = UserPreference();
    PreferenceData userData = await userPreference.getUserInfromation();
    PreferenceData tokenData = await userPreference.getUserToken();
    setState(() {
      user = userData.data;
      token = tokenData.data;
    });
  }

  @override
  void initState() {
    getInformations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                " Join fundraising team for \"Helping fundraisers \"",
                textAlign: TextAlign.center,
                style: labelTextStyle.copyWith(
                    fontSize: 24.0,
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: VerifyButton(
              onPressed: () async {
                if (user != null) {
                  String fundraiseId = widget.data.substring(25);

                  acceptInvitation(context, user!.email!, token!, fundraiseId);
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SigninPage(
                        url: widget.data.substring(25),
                      ),
                    ),
                  );
                }
              },
              title: "Accept",
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: VerifyButton(
              title: "Decline",
              onPressed: () async {
                String fundraiseId = widget.data.substring(25);
                declineInvitaion(context, user!.email!, token!, fundraiseId);
              },
            ),
          )
        ],
      )),
    );
  }
}
