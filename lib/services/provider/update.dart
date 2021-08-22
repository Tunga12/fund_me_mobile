import 'dart:io';

import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/services/repository/update.dart';
import 'package:flutter/cupertino.dart';

class UpdateModel extends ChangeNotifier {
  UpdateRepository updateRepository;

  UpdateModel({
    required this.updateRepository,
  });

  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');

  // get Response
  Response get response => _response;

  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  // create an update for a fundraiser
  Future createUpdate(Update update, String token, String fundraiseId,
      {File? image}) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      bool updateResponse = await updateRepository
          .createUpdate(update, token, fundraiseId, image: image);
      print(" update Response $updateResponse");
      if (updateResponse) {
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: updateResponse,
            message: "successfully created update");
      } else {
        response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: null,
          message: "unable to update",
        );
      }
      print(_response.status);
    } on SocketException {
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
        message: e.toString(),
      );
    }
  }

  // delete a single fundraiser
  Future deleteUpdate(String updateId, String token) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      final updateResponse =
          await updateRepository.deleteUpdate(updateId, token);
      print(" update Response $updateResponse");
      if (updateResponse == 'deleted')
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: updateResponse,
            message: "Successfully deleted update");
      print(_response.status);
    } on SocketException {
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
        message: e.toString(),
      );
    }
  }
}
