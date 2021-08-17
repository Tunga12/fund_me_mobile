import 'dart:async';

import 'package:flutter/services.dart';

abstract class TeamProvider {
  void dispose();
}

class TeamAddModel extends TeamProvider {
  //Event Channel creation
  static const stream = const EventChannel('https.shrouded-bastion-52038.herokuapp.com/events');

  //Method channel creation
  static const platform = const MethodChannel('https.shrouded-bastion-52038.herokuapp.com/channel');

  StreamController<String> _stateController = StreamController();

  Stream<String> get state => _stateController.stream;

  Sink<String> get stateSink => _stateController.sink;

  //Adding the listener into contructor

  TeamAddModel() {
    //Checking application start by deep link
    startUri().then(_onRedirected);
    //Checking broadcast stream, if deep link was clicked in opened appication
    stream.receiveBroadcastStream().listen((d) => _onRedirected(d));
  }

  _onRedirected(String uri) {
    // Here can be any uri analysis, checking tokens etc, if its necessary
    // Throw deep link URI into the BloC's stream
    stateSink.add(uri);
  }

  @override
  void dispose() {
    _stateController.close();
  }

  Future<String> startUri() async {
    try {
      String? data;
      await platform.invokeMethod('initialLink').then((value) {
        data = value;
      });
      return data!;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}
