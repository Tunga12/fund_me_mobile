import 'dart:io';

import 'package:crowd_funding_app/Models/report.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/services/repository/report.dart';
import 'package:flutter/material.dart';

class ReportModel extends ChangeNotifier {
  final ReportRepository reportRepository;

  ReportModel({required this.reportRepository});

  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');

  Response get response => _response;

  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Future createReport(Report report, String token) async {
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      final reportResponse = await reportRepository.createReport(report, token);
      if(reportResponse is Report)
      response = Response(status: ResponseStatus.SUCCESS, data: reportResponse, message: 'success');
    } on SocketException catch (e) {
     
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      print('Fundraise Error ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: null,
          message: e.toString());
    }
  }
}
