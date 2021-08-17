import 'dart:io';

import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/services/repository/donation.dart';
import 'package:flutter/material.dart';

class DonationModel extends ChangeNotifier {
  final DonationRepository donationRepository;
  DonationModel({required this.donationRepository});
  Response _response =
      Response(status: ResponseStatus.LOADING, data: '', message: '');

  Response get response => _response;

  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Future createDonation(
      Donation donation, String token, String fundraiserId) async {
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      Donation donationResponse = await donationRepository.createDonation(
          donation, token, fundraiserId);
      response = Response(
          status: ResponseStatus.SUCCESS,
          data: donationResponse,
          message: "successfully donated!");
    } on SocketException catch (e) {
      print("Socket exception Error ${e.message}");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: '',
          message: "No internet connection");
    } on FormatException catch (e) {
      print('Format Exception Error ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: '',
          message: "Invalid response from the server");
    } catch (e) {
      response = Response(
        status: ResponseStatus.MISMATCHERROR,
        data: '',
        message: e.toString(),
      );
      print("Donation  error ${e.toString()}");
    }
  }

  // pay with paypal
  Future payWithPayPal(
      Donation donation, String token, String fundraiserId) async {
    try {
      // final donationResponse =
      response =
          Response(status: ResponseStatus.LOADING, data: '', message: '');
      final url =
          await donationRepository.payWithPayPal(donation, token, fundraiserId);
      if (url.startsWith("https"))
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: url,
            message: "successfully donated!");
    } on SocketException catch (e) {
      print("Socket exception Error ${e.message}");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: '',
          message: "No internet connection");
    } on FormatException catch (e) {
      print('Format Exception Error ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: '',
          message: "Invalid response from the server");
    } catch (e) {
      response = Response(
        status: ResponseStatus.MISMATCHERROR,
        data: '',
        message: "error occured",
      );
      print("Donation  error ${e.toString()}");
    }
  }
}
