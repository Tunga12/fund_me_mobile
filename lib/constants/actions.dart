import 'dart:convert';
import 'dart:io';

import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/services/provider/team_member.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

void createFundraiser(BuildContext context, Map<String, dynamic> fundraiseInfo,
    File image, Response response) async {
  loadingProgress(context);
  PreferenceData userInfo = await UserPreference().getUserInfromation();

  String byte64Image = base64Encode(image.readAsBytesSync());
  String fileImage = image.path.split('/').last;

  Fundraise fundraise = Fundraise(
    title: fundraiseInfo['title'],
    story: fundraiseInfo['story'],
    location: fundraiseInfo['location'],
    category: fundraiseInfo['category'],
    image: byte64Image + ":" + fileImage,
    goalAmount: int.parse(fundraiseInfo['goalAmount']),
    beneficiary: userInfo.data,
  );
  PreferenceData tokenInfo = await UserPreference().getUserToken();
  String token = tokenInfo.data;

  await context.read<FundraiseModel>().createFundraise(fundraise, token);
  if (response.status == ResponseStatus.CONNECTIONERROR) {
    authShowDialog(context, Text(response.message), error: true, close: true);
    return;
  } else if (response.status == ResponseStatus.FORMATERROR) {
    authShowDialog(context, Text(response.message), error: true, close: true);
    return;
  } else if (response.status == ResponseStatus.MISMATCHERROR) {
    authShowDialog(
        context,
        Text(
          response.message,
        ),
        error: true,
        close: true);
    return;
  } else if (response.status == ResponseStatus.SUCCESS) {
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: "Successfully created!", toastLength: Toast.LENGTH_LONG);
    Navigator.of(context).pushNamedAndRemoveUntil(
      HomePage.routeName,
      (Route<dynamic> route) => false,
    );
    return;
  } else {}
  authShowDialog(
      context,
      Text(
        response.message,
      ),
      error: true,
      close: true);
}

void acceptInvitation(BuildContext context, String email, String token,
    String fundraiseId) async {
  await context
      .read<TeamMemberModel>()
      .createTeamMember(email, token, fundraiseId);
  Response response = context.read<TeamMemberModel>().response;
  await context
      .read<TeamMemberModel>()
      .verifyTeamMember(true, token, fundraiseId);
  response = context.read<TeamMemberModel>().response;
  if (response.status == ResponseStatus.SUCCESS) {
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  } else if (response.status == ResponseStatus.LOADING) {
  } else {
    ResponseAlert(response.message);
  }
}

void declineInvitaion(BuildContext context, String email, String token,
    String fundraiseId) async {
  await Provider.of<TeamMemberModel>(context)
      .createTeamMember(email, token, fundraiseId);
  Response response = context.read<TeamMemberModel>().response;
  await context
      .read<TeamMemberModel>()
      .verifyTeamMember(false, token, fundraiseId);
  response = context.read<TeamMemberModel>().response;
  if (response.status == ResponseStatus.SUCCESS) {
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  } else if (response.status == ResponseStatus.LOADING) {
  } else {
    ResponseAlert(response.message);
  }
}
