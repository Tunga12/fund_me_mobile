import 'dart:io';

import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/services/repository/currency.dart';
import 'package:flutter/cupertino.dart';

class CurrencyRateModel extends ChangeNotifier {
  final CurrencyRepository repository;
  CurrencyRateModel({required this.repository});

  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');
  // get response
  Response get response => _response;

  // set response
  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Future getCurrencyRate() async {
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      final currencyRate = await repository.getCurrencyRate();
      if (currencyRate is double) {
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: currencyRate,
            message: "Success");
      }
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
      print("Category error error ${e.toString()}");
      response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: null,
          message: e.toString());
    }
  }
}
