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

  Future getPopularFundraises(int page) async {
   
    try {
       response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
      HomeFundraise _homeFundraise =
          await fundraiseRepository.getPopularFundraises(page);
      response = Response(
          status: ResponseStatus.SUCCESS,
          data: _homeFundraise.fundraises,
          message: "success");
      homeFundraise = _homeFundraise;
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
          message: "failed to get fundraisers");
    }
  }

  Future getSingleFundraise(String id) async {
    print("User id is $id");
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      final _fundraise = await fundraiseRepository.getSingleFundraise(id);

      if (_fundraise is Fundraise)
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: _fundraise,
            message: "success");
      fundraise = _fundraise;
    } on SocketException catch (e) {
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      print('Fundraise Error ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR, data: null, message: e.message);
    } catch (e) {
      response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: null,
          message: e.toString());
    }
  }

  Future createFundraise(Fundraise fundraise, String token, File image) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      bool createResponse =
          await fundraiseRepository.createFundraise(fundraise, token, image);
      print("Create response $createResponse");
      if (createResponse)
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: createResponse,
            message: "success");
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
          message: "failed to create fundraiser");
    }
  }

  Future getUserFundaisers(String token, int page) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      HomeFundraise _homeFundraise =
          await fundraiseRepository.getUserFundaisers(token, page);
      response = Response(
          status: ResponseStatus.SUCCESS,
          data: _homeFundraise.fundraises,
          message: "success");
      homeFundraise = _homeFundraise;
      print("In popular fundraise model");
      print(response.status);
      notifyListeners();
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
          message: "failed to fetch your fundraisers.");
    }
  }

  Future benficiaryFundraiser(String token, int page) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      final _homeFundraise =
          await fundraiseRepository.beneficiaryFundraisers(token, page);
      if (_homeFundraise is HomeFundraise)
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: _homeFundraise.fundraises,
            message: "success");
      homeFundraise = _homeFundraise;
      print("In popular fundraise model");
      print(response.status);
      notifyListeners();
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
          message: "failed to fetch your fundraisers.");
    }
  }

  Future updateFundraise(Fundraise fundraise, String token,
      {File? image}) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      bool fundraiseResponse = await fundraiseRepository
          .updateFundraise(fundraise, token, image: image);
      if (fundraiseResponse)
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
          message: "failed to update");
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
  Future getMemberFundrases(String token, int page) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      HomeFundraise _homeFundraise =
          await fundraiseRepository.getMemberFundrases(token, page);

      response = Response(
          status: ResponseStatus.SUCCESS,
          data: _homeFundraise.fundraises,
          message: "success");
      homeFundraise = _homeFundraise;
      print("In popular fundraise model");
      print(response.status);
      notifyListeners();
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
          data: null,
          status: ResponseStatus.MISMATCHERROR,
          message: 'Unable to load');
    }
  }

  // search fundraises
  Future searchFundraises(String title, int pageNumber) async {
    print("searched title is $title");
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: '', message: '');
      final _fundraiseResponse =
          await fundraiseRepository.searchFundraises(title, pageNumber);
      print('search data is $_fundraiseResponse');
      print("${_fundraiseResponse is HomeFundraise}");
      if (_fundraiseResponse is HomeFundraise)
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: _fundraiseResponse,
            message: 'successfully searched');
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
          message: "unable to search data");
    }
  }

  // Signingout
  Future signOut() async {
    response =
        Response(data: null, status: ResponseStatus.LOADING, message: "");
  }
}
