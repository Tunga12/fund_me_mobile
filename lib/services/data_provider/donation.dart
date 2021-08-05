import 'dart:convert';

import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class DonationDataProvider {
  final http.Client httpClient;

  DonationDataProvider({required this.httpClient});

  Future<Donation> createDonation(
      Donation donation, String token, String fundraiserId) async {
    print(
      "donation is $donation",
    );
    print(fundraiserId);
    print(token);
    final response = await httpClient.post(
      Uri.parse(EndPoints.createDonation + fundraiserId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      body: jsonEncode(
        <String, dynamic>{
          'userId': donation.userID,
          'memberId': donation.memberID,
          "amount": donation.amount,
          'tip': donation.tip,
          "comment": donation.comment,
        },
      ),
    );

    if (response.statusCode == 201) {
      return donation;
    } else {
      print("donation exception ${response.body}");
      throw Exception(response.body);
    }
  }
}
