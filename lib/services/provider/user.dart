import 'dart:io';

import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/services/repository/user.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  UserRepository userRepository;
  UserModel({
    required this.userRepository,
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

  // get single user user informations
  Future<void> getUser(String token, String password) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');
    try {
      User user = await userRepository.getUser(token, password);
      response = Response(
          status: ResponseStatus.SUCCESS, data: user, message: "Success");
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
          message: "User not found");
    }
  }

  // get user informations
  Future<void> updateUser(User user, String token) async {
    response =
        Response(status: ResponseStatus.LOADING, data: null, message: '');

    try {
      final userReponse = await userRepository.updateUser(user, token);
      print(userReponse is User);
      if (userReponse is User)
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: userReponse,
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
      print(e.toString());
      response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: null,
          message: "unable to update user");
    }
  }

  // delete user
  // get user informations
  Future<void> deleteUser(String token) async {
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      String userReponse = await userRepository.deleteuser(token);
      response = Response(
          status: ResponseStatus.SUCCESS,
          data: userReponse,
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

  // forgot password
  Future forgotPassword(String email) async {
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      final userReponse = await userRepository.forgotPassword(email);
      if (userReponse)
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: userReponse,
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

  // reset password
  Future resetPassword(String password, String userId) async {
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      final userReponse = await userRepository.resetPassword(password, userId);
      if (userReponse is User)
        response = Response(
            status: ResponseStatus.SUCCESS,
            data: userReponse,
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

  Future signOut() async {
    response =
        Response(data: null, status: ResponseStatus.LOADING, message: "");
  }
}
