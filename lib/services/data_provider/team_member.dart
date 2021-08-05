import 'dart:convert';

import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeamMemberDataProvider {
  final http.Client httpClient;
  TeamMemberDataProvider({
    required this.httpClient,
  });

  Future<TeamMember> createTeamMember(
      String email, String token, String fundraiseId) async {
    final response = await httpClient.post(
      Uri.parse(EndPoints.createTeamMember + fundraiseId),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        'x-auth-token': token,
      },
      body: jsonEncode(
        <String, dynamic>{
          "email": email,
        },
      ),
    );

    if (response.statusCode == 200) {
      return TeamMember.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<String> verifyTeamMember(
      bool status, String token, String fundraiseId) async {
    final response = await httpClient.put(
      Uri.parse(EndPoints.verifyInvitaion + fundraiseId),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": token,
      },
      body: jsonEncode(
        <String, dynamic>{
          'accepted': status,
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(response.body);
    }
  }
}
