import 'dart:io';

import 'package:crowd_funding_app/Models/help.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/services/data_provider/help.dart';
import 'package:crowd_funding_app/services/repository/help.dart';
import 'package:flutter/cupertino.dart';

class HelpModel extends ChangeNotifier {
  final HelpRepository helpRepository;
  HelpModel({required this.helpRepository});

  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');

  bool _deleteUpdate = false;

  // get Response
  Response get response => _response;

  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Future getHelp() async {
    try {
      Response(status: ResponseStatus.LOADING, data: null, message: '');
      final _response = await helpRepository.getHelp();
      if (_response is List<HelpDataModel>)
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: _response,
            message: "successfully fetched help");
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
        message: 'failed to get help',
      );
    }
  }
}
