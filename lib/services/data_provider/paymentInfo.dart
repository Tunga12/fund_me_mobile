import 'dart:convert';

import 'package:crowd_funding_app/Models/paymentInfo.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class PaymentInfoDataProvider {
  final http.Client httpClient = http.Client();

  searchShortcode(String shortcode) async {
    final response = await httpClient.get(
      Uri.parse(EndPoints.paymentInfo + '/search/$shortcode'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      print("success shortcode");
      final paymentInfo = jsonDecode(response.body) as Map<String, dynamic>;
      return PaymentInfo.fromJson(paymentInfo);
    } else {
      print("The exception is ");
      print(response.body);
      throw Exception(response.body);
    }
  }

  getPaymentInfo(String id) async {
    final response = await httpClient.get(
      Uri.parse(EndPoints.paymentInfo + '/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      print("success paymentInfo by id");
      final paymentInfo = jsonDecode(response.body) as Map<String, dynamic>;
      return PaymentInfo.fromJson(paymentInfo);
    } else {
      print("The exception is ");
      print(response.body);
      throw Exception(response.body);
    }
  }
}
