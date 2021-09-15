import 'dart:convert';

import 'package:crowd_funding_app/Models/withdrawal.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class WithdrawDataProvider {
  final http.Client httpClient;

  WithdrawDataProvider({required this.httpClient});

  Future<bool> createWithdrawal(
      Withdrwal withdrwal, String token, String fundraiserId) async {
    final response = await httpClient.post(
      Uri.parse(EndPoints.withdrawalUrl + fundraiserId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      body: jsonEncode(
        <String, dynamic>{
          'bankName': withdrwal.bankName,
          'bankAccountNo': withdrwal.bankAccountNo.toString(),
          'isOrganizer': withdrwal.isOrganizer,
          // if (!withdrwal.isOrganizer) 'beneficiary': withdrwal.beneficiary
        },
      ),
    );

    print("Create withdrawal status ${response.statusCode}");

    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.body);
      print("exception creating withdrawal");
      throw Exception("unable to request withdrawal");
    }
  }

  Future<String> inviteBeneficiary(
      String email, String token, String fundraiseId) async {
    final response = await httpClient.post(
      Uri.parse(EndPoints.inviteUrl + fundraiseId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      body: jsonEncode(
        <String, dynamic>{
          'email': email,
        },
      ),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode >= 200 && response.statusCode < 250) {
      print("entering condition");

      return response.body;
    } else {
      throw Exception(response.body);
    }
  }
}
