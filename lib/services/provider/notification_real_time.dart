import 'dart:async';
import 'dart:convert';

import 'package:crowd_funding_app/Models/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class NotificationProvider {
  void dispose();
}

class NotificationRealTimeModel extends NotificationProvider
    with ChangeNotifier {
  StreamController<List<UserNotification>> _newNotifications =
      StreamController();
  StreamController<int> _unreadNotificationCount = StreamController();
  // StreamController<UserNotification> _viewedNotifications = StreamController();

  // add new notifications
  void Function(List<UserNotification> notification) get addNewNotification =>
      _newNotifications.sink.add;

  // get new notifications
  Stream<List<UserNotification>> get getNewNotifications =>
      _newNotifications.stream;

  // add unread notifications count
  void Function(int unreadNotificationsCount) get addUnreadNotificationCount =>
      _unreadNotificationCount.sink.add;

  // get unread notificatons count
  Stream<int> get getUnreadNotificationsCount =>
      _unreadNotificationCount.stream;

  // // add viewd notifications
  // void Function(UserNotification notification) get addViewedNotification =>
  //     _viewedNotifications.sink.add;

  // // get viewed notifications
  // Stream<UserNotification> get getViewedNotificationsCount =>
  //     _viewedNotifications.stream;

  createConnection(String token) {
    String URL = 'https://shrouded-bastion-52038.herokuapp.com?token=$token';
    IO.Socket socket =
        IO.io(URL, IO.OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      print('connect');
      print("It connected");
    });

    
    // viewed notifications
    socket.on('viewed notification', (data) {
      
      final responseData = jsonDecode(data) as List;
      List<UserNotification> _notifications = responseData
          .map((notification) =>
              UserNotification.fromJson(jsonDecode(notification)))
          .toList();
      addNewNotification(_notifications);
    });

    // new notifications
    socket.on('new notification', (data) {
      final responseData = jsonDecode(data) as List;
      List<UserNotification> _notifications = responseData
          .map((notification) =>
              UserNotification.fromJson(jsonDecode(notification)))
          .toList();
      addNewNotification(_notifications);
    });

    // viewed 
    socket.on('unread notification count',
        (data) => addUnreadNotificationCount(data));
    socket.onError((data) => print("Error happend error"));
  }

  @override
  void dispose() {
    _newNotifications.close();
    _unreadNotificationCount.close();
    // _viewedNotifications.close();
  }
}
