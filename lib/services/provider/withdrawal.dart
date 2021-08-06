import 'dart:io';

import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/withdrawal.dart';
import 'package:crowd_funding_app/services/repository/withdrawal.dart';
import 'package:flutter/material.dart';

class WithdrawalModel extends ChangeNotifier {
  final WithdrawalRepository withdrawalRepository;

  WithdrawalModel({
    required this.withdrawalRepository,
  });

  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');

  // get response
  Response get response => _response;

  // set resonse;
  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Future createWithdrawal(
      Withdrwal withdrwal, String token, String fundraiserId) async {
    try {
      bool createResponse = await withdrawalRepository.createWithdrawal(
          withdrwal, token, fundraiserId);
      if (createResponse)
        response = response = Response(
            status: ResponseStatus.SUCCESS,
            data: createResponse,
            message: "Success");
    } on SocketException catch (e) {
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
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
