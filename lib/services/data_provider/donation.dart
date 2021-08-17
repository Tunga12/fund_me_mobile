import 'dart:convert';

import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

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
          'isAnonymous': donation.isAnonymous,
          if (donation.memberID != null) 'memberId': donation.memberID,
          "amount": donation.amount,
          'tip': donation.tip,
          "comment": donation.comment,
        },
      ),
    );
    print('Status code is ');
    print(response.statusCode);

    if (response.statusCode == 201) {
      return donation;
    } else {
      print("donation exception ${response.body}");
      throw Exception(response.body);
    }
  }

  // donation with paypal
  Future<String> payWithPayPal(
      Donation donation, String token, String fundraiserId) async {
    print("donation tip");
    print(
      donation.tip!.toInt(),
    );
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
        },
      ),
    );

    if (response.statusCode == 302) {
      print('redirection url is ');
      print(response.body);
      print(response.headers['location']);
      String url = response.headers['location'] ?? "";
      return url;
    } else {
      print("donation exception ${response.body}");
      throw Exception(response.body);
    }
  }
}
