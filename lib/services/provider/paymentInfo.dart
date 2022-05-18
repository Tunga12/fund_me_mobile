import 'dart:io';

import 'package:crowd_funding_app/Models/paymentInfo.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/services/repository/paymentInfo.dart';
import 'package:flutter/material.dart';

class PaymentInfoProvider extends ChangeNotifier {
  PaymentInfoRepository paymentInfoRepository = PaymentInfoRepository();

  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');

  // get response
  Response get response => _response;

  // set response
  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  // get a paymentInfo, search shortcode
  Future searchShortcode(String shortcode) async {
    try {
      PaymentInfo paymentInfo =
          await paymentInfoRepository.searchShortcode(shortcode);
      print('paymentInfo $paymentInfo');

      response = Response(
          status: ResponseStatus.SUCCESS,
          data: paymentInfo,
          message: "successfully fetched");
    } on SocketException catch (e) {
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on Exception catch (e) {
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    }
  }

  // get a paymentInfo by id
  Future getPaymentInfo(String id) async {
    try {
      PaymentInfo paymentInfo = await paymentInfoRepository.getPaymentInfo(id);
      print('paymentInfo $paymentInfo');

      response = Response(
          status: ResponseStatus.SUCCESS,
          data: paymentInfo,
          message: "successfully fetched");
    } on SocketException catch (e) {
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on Exception catch (e) {
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    }
  }
}
