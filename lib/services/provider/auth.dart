import 'dart:async';
import 'dart:io';

import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/services/repository/auth.dart';
import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  AuthStatus _signinStatus = AuthStatus.NOTLOGGEDIN;
  AuthStatus _signupStatus = AuthStatus.NOTREGISTERED;

  Response? _response;
  AuthRepository authRepository;

  AuthModel({
    required this.authRepository,
  });

  // getting signin status
  AuthStatus get signinStatus => _signinStatus;

  // setting signin status
  set signinStatus(AuthStatus value) {
    _signinStatus = value;
    notifyListeners();
  }

  // getting signup status
  AuthStatus get signupStatus => _signupStatus;

  // setting signup status
  set signupStatus(AuthStatus value) {
    _signupStatus = value;
    notifyListeners();
  }

  // getting response
  Response get response => _response!;
  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Future signupUser(User user) async {
    signupStatus = AuthStatus.REGISTERING;
    try {
      String token = await authRepository.createUser(user);
      signupStatus = AuthStatus.REGISTERED;
      response = Response(
          status: ResponseStatus.SUCCESS,
          data: token,
          message: 'Successfully registered');
    } on SocketException catch (e) {
      print("Sign up socket Error message ${e.message}");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: false,
          message: 'no internet connection');
      signupStatus = AuthStatus.NOTREGISTERED;
    } on FormatException catch (e) {
      print("Signup format Error message ${e.message}");
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: false,
          message: 'invalid response received');
      signupStatus = AuthStatus.NOTREGISTERED;
    } catch (e) {
      print("Signup Error message ${e.toString()}");
      response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: false,
          message: '${e.toString().substring(10)}');
      signupStatus = AuthStatus.NOTREGISTERED;
    }
  }

  Future signinUser(User user) async {
    signinStatus = AuthStatus.AUTHENTICATING;
    try {
      String token = await authRepository.signinUser(user);
      signinStatus = AuthStatus.LOGGEDIN;
      response = Response(
          status: ResponseStatus.SUCCESS,
          data: token,
          message: 'succesfully logged in');
    } on SocketException catch (e) {
      print("Error message ${e.message}");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: false,
          message: 'no internet connection');
      signinStatus = AuthStatus.NOTLOGGEDIN;
    } on FormatException catch (e) {
      print("Error message ${e.message}");
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: false,
          message: 'invalid response received');
      signinStatus = AuthStatus.NOTLOGGEDIN;
    } catch (e) {
      print("error message ${e.toString()}");
      response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: false,
          message: 'Incorrect email or password!');
      signinStatus = AuthStatus.NOTLOGGEDIN;
    }
  }

  Future signOut() async {
    signinStatus = AuthStatus.NOTLOGGEDIN;
    signupStatus = AuthStatus.NOTREGISTERED;
    response =
        Response(data: null, status: ResponseStatus.LOADING, message: "");
  }
}
