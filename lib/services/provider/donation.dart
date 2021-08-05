import 'dart:io';

import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/services/repository/donation.dart';
import 'package:flutter/material.dart';

class DonationModel extends ChangeNotifier {
  final DonationRepository donationRepository;
  DonationModel({required this.donationRepository});
  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');

  Response get response => _response;

  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Future createDonation(
      Donation donation, String token, String fundraiserId) async {
    Response _response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
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
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      print('Format Exception Error ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
      print("Donation  error ${e.toString()}");
    }
  }
}
