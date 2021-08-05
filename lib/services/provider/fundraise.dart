import 'dart:async';
import 'dart:io';

import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/services/repository/fundraise.dart';
import 'package:flutter/material.dart';

class FundraiseModel extends ChangeNotifier {
  FundraiseRepository fundraiseRepository;
  FundraiseModel({
    required this.fundraiseRepository,
  });

  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');
  HomeFundraise _homeFundraise = HomeFundraise();
  Fundraise _fundraise = Fundraise();

  HomeFundraise get homeFundraise => _homeFundraise;
  Fundraise get fundraise => _fundraise;

  set homeFundraise(HomeFundraise homeFundraise) {
    _homeFundraise = homeFundraise;
    notifyListeners();
  }

  set fundraise(Fundraise fundraise) {
    _fundraise = fundraise;
    notifyListeners();
  }

  Response get response => _response;

  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Future getPopularFundraises() async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      HomeFundraise _homeFundraise =
          await fundraiseRepository.getPopularFundraises();

      response = Response(
          status: ResponseStatus.SUCCESS,
          data: _homeFundraise.fundraises,
          message: "success");
      homeFundraise = _homeFundraise;
      print("In popular fundraise model");
      print(response.status);
      notifyListeners();
    } on SocketException catch (e) {
      print("Fundraise Error ${e.message}");
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
      print("fundraise error ${e.toString()}");
    }
  }

  Future getSingleFundraise(String id) async {
    print("User id is $id");
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      Fundraise _fundraise = await fundraiseRepository.getSingleFundraise(id);
      response = Response(
          status: ResponseStatus.SUCCESS, data: _fundraise, message: "success");
      fundraise = _fundraise;
      notifyListeners();
    } on SocketException catch (e) {
      print("Fundraise Error ${e.message}");
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
      print("fundraise error ${e.toString()}");
    }
  }

  Future createFundraise(Fundraise fundraise, String token) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      await fundraiseRepository.createFundraise(fundraise, token);
      response = Response(
          status: ResponseStatus.SUCCESS, data: null, message: "success");
      notifyListeners();
    } on TimeoutException catch (e) {
      print("time out");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "Request timeout");
    } on SocketException catch (e) {
      print("Socket Exception ${e.message}");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      print('Format exception ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      print("Create error ${e.toString()}");
      response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: null,
          message: "${e.toString()}");
    }
  }

  Future getUserFundaisers(String token) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      HomeFundraise _homeFundraise =
          await fundraiseRepository.getUserFundaisers(token);

      response = Response(
          status: ResponseStatus.SUCCESS,
          data: _homeFundraise.fundraises,
          message: "success");
      homeFundraise = _homeFundraise;
      print("In popular fundraise model");
      print(response.status);
      notifyListeners();
    } on SocketException catch (e) {
      print("Fundraise Error ${e.message}");
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
      print("fundraise error ${e.toString()}");
    }
  }

  Future updateFundraise(Fundraise fundraise, String token) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      Fundraise fundraiseResponse =
          await fundraiseRepository.updateFundraise(fundraise, token);
      response = Response(
          status: ResponseStatus.SUCCESS,
          data: fundraiseResponse,
          message: "success");
      notifyListeners();
    } on TimeoutException catch (e) {
      print("time out");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "Request timeout");
    } on SocketException catch (e) {
      print("Socket Exception ${e.message}");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      print('Format exception ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      print("update error ${e.toString()}");
      response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: null,
          message: "${e.toString()}");
    }
  }

  Future deleteFundraise(String id, String token) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      String fundraiseResponse =
          await fundraiseRepository.deleteFundraise(id, token);
      response = Response(
          status: ResponseStatus.SUCCESS,
          data: fundraiseResponse,
          message: "success");
      notifyListeners();
    } on TimeoutException catch (e) {
      print("time out");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "Request timeout");
    } on SocketException catch (e) {
      print("Socket Exception ${e.message}");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      print('Format exception ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      print("update error ${e.toString()}");
      response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: null,
          message: "${e.toString()}");
    }
  }

  // get all fundraises for a member
  Future getMemberFundrases(String token) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      HomeFundraise _homeFundraise =
          await fundraiseRepository.getMemberFundrases(token);

      response = Response(
          status: ResponseStatus.SUCCESS,
          data: _homeFundraise.fundraises,
          message: "success");
      homeFundraise = _homeFundraise;
      print("In popular fundraise model");
      print(response.status);
      notifyListeners();
    } on SocketException catch (e) {
      print("Fundraise Error ${e.message}");
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
      print("fundraise error ${e.toString()}");
    }
  }

  // Signingout
  Future signOut() async {
    response =
        Response(data: null, status: ResponseStatus.LOADING, message: "");
  }
}
