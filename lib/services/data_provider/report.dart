import 'dart:convert';

import 'package:crowd_funding_app/Models/report.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class ReportDataProvider {
  final http.Client httpClient;
  ReportDataProvider({
    required this.httpClient,
  });

  Future<Report> createReport(Report report, String token) async {
    final response = await httpClient.post(
        Uri.parse(
          EndPoints.reportFundraiserURL,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
        body: jsonEncode(report.toJson()));

    print("status code is response code");
    print(response.statusCode);

    if (response.statusCode >= 200 && response.statusCode <= 230) {
      return Report.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
