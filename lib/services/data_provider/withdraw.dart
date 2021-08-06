import 'dart:convert';
import 'dart:math';

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
        },
      ),
    );

    print("Create withdrawal status ${response.statusCode}");

    if (response.statusCode == 201) {
      return true;
    } else {
      print("exception creating withdrawal");
      throw Exception("unable to request withdrawal");
    }
  }
}
