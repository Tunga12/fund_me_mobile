import 'dart:convert';

import 'package:crowd_funding_app/Models/reason.dart';
import 'package:crowd_funding_app/Models/report.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class ReportDataProvider {
  final http.Client httpClient;
  ReportDataProvider({
    required this.httpClient,
  });

  // report a fundraiser if it is illegal
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

  // fetch report reasons;
  Future<List<ReportReason>> getReportReasons() async {
    print("getting report reasons");
    final response = await httpClient.get(
      Uri.parse(EndPoints.reportReasonURL),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final reasonResponse = jsonDecode(response.body) as List;
      List<ReportReason> reportReason = reasonResponse
          .map((reason) => ReportReason.fromJson(reason))
          .toList();
      print(reportReason);
      return reportReason;
    } else {
      throw Exception(response.body);
    }
  }
}
