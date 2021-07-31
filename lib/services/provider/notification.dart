import 'dart:io';

import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/services/repository/notification.dart';
import 'package:flutter/material.dart';
import 'package:crowd_funding_app/Models/notification.dart';

class UserNotificationModel extends ChangeNotifier {
  UserNotificationRepository notificationRepository;
  UserNotificationModel({required this.notificationRepository});
  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');

  // get Response
  Response get response => _response;

  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Future<void> getAllUserNotifications(String token) async {
    print("getting all user notification");
    try {
      List<UserNotification> userNotifications =
          await notificationRepository.getUserNotifications(token);
      print("user notificatons $userNotifications");
      response = Response(
          status: ResponseStatus.SUCCESS,
          data: userNotifications,
          message: "successfully fetched notifications");
      print(_response.status);
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
          message: "failed to fetch notifications");
    }
  }

  Future signOut() async {
    response =
        Response(data: null, status: ResponseStatus.LOADING, message: "");
  }
}
