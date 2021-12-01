import 'dart:convert';

import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class DonationDataProvider {
  final http.Client httpClient;

  DonationDataProvider({required this.httpClient});

  Future<Donation> createDonation(
      Donation donation, String token, String fundraiserId) async {
    final response = await httpClient.post(
      Uri.parse(EndPoints.createDonation + fundraiserId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      body: jsonEncode(
        <String, dynamic>{
          'isAnonymous': donation.isAnonymous,
          if (donation.memberID != null) 'memberId': donation.memberID,
          "amount": donation.amount,
          'tip': donation.tip,
          "comment": donation.comment,
        },
      ),
    );

 

    if (response.statusCode == 201) {
      return donation;
    } else {
      throw Exception(response.body);
    }
  }

  // donation with paypal
  Future<String> payWithPayPal(
      Donation donation, String token, String fundraiserId) async {
    final response = await httpClient.post(
      Uri.parse(EndPoints.paypalUrl + fundraiserId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      body: jsonEncode(
        <String, dynamic>{
          'isAnonymous': donation.isAnonymous,
          if (donation.memberID != null) 'memberId': donation.memberID,
          "amount": donation.amount,
          'tip': donation.tip,
          "comment": donation.comment,
          "paymentMethod": "paypal"
        },
      ),
    );
    if (response.statusCode == 302) {
      String url = response.headers['location'] ?? "";
      return url;
    } else {
      throw Exception(response.body);
    }
  }
}
