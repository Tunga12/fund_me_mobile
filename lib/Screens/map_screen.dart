import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  final MapArgument args;
  MapScreen({required this.args});
  static const routeName = 'map';
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapScreen> {
  List<Marker> myMarker = [];
  GoogleMapController? mapController;
  // final LatLng _center = LatLng(9, 38.7);

  LatLng? _currentLocation;
  void _onMapCreated(GoogleMapController controller) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    setState(
      () {
        _currentLocation = LatLng(position.latitude, position.longitude);
        print('on map cerrated  $_currentLocation');

        myMarker = [];
        myMarker.add(
          Marker(
            markerId: MarkerId(_currentLocation.toString()),
            position: _currentLocation!,
            draggable: true,
            onDragEnd: (value) => _handleTap(_currentLocation!),
          ),
        );
      },
    );
    mapController = controller;
    await centerScreen(position);
  }

  StreamSubscription<Position>? locationSubscription;

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() {
    setState(() {
      locationSubscription =
          GeolocatorService().getCurrentLocation().listen((position) async {
        setState(
          () {
            _currentLocation = LatLng(position.latitude, position.longitude);
            // print('iinit  $_currentLocation');
            myMarker = [];
            myMarker.add(
              Marker(
                markerId: MarkerId(_currentLocation.toString()),
                position: _currentLocation!,
                draggable: true,
                onDragEnd: (value) => _handleTap(_currentLocation!),
              ),
            );
          },
        );
        for (int i = 0; i <= 10; i++) {
          print("position is $position");
        }

        await centerScreen(position);
      });
    });
  }

  @override
  void dispose() {
    locationSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = widget.args.location;
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          markers: Set.from(myMarker),
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 18.0,
          ),
          mapType: MapType.satellite,
          onTap: _handleTap,
          myLocationButtonEnabled: true,
        ),
        Positioned(
            bottom: 0,
            left: 100,
            child: widget.args.isUser
                ? TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).accentColor),
                    onPressed: () async {
                      var address = await _fetchLocation(_currentLocation!);
                      Navigator.of(context).pop(LocationArgument(
                          latitude:
                              _currentLocation!.latitude.toStringAsFixed(5),
                          longitude:
                              _currentLocation!.longitude.toStringAsFixed(5),
                          address: address));
                    },
                    child: Text(
                      "Confirm Location",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Container()),
        Positioned(
            top: 20,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ))
      ]),
    );
  }

  Future<void> centerScreen(Position position) async {
    if (mapController == null) {
      return;
    }
    await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 18.0),
      ),
    );
  }

  void _handleTap(LatLng tappedPoint) {
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        draggable: true,
        onDragEnd: (value) => _handleTap(value),
      ));
      _currentLocation = tappedPoint;
      print(tappedPoint);
    });
    centerScreen(Position(
        latitude: _currentLocation!.latitude,
        longitude: _currentLocation!.longitude,
        altitude: 0.0,
        speed: 0.0,
        accuracy: 0.0,
        heading: 0.0,
        timestamp: DateTime.now(),
        speedAccuracy: 0.0));
  }

  Future<String> _fetchLocation(LatLng position) async {
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.best);

    ///Here you have choose level of distance
    var latitude = position.latitude.toString();
    var longitude = position.longitude.toString();
    var placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    var address =
        '${placemarks.first.name!.isNotEmpty ? placemarks.first.name! + ', ' : ''}${placemarks.first.subLocality!.isNotEmpty ? placemarks.first.subLocality! + ', ' : ''}${placemarks.first.locality!.isNotEmpty ? placemarks.first.locality! + ', ' : ''}${placemarks.first.subAdministrativeArea!.isNotEmpty ? placemarks.first.subAdministrativeArea! + ', ' : ''}';
    print("latitude" + latitude);
    print("longitude" + longitude);
    print("adreess  " + address);
    return address;
  }
}

class GeolocatorService {
  Stream<Position> getCurrentLocation() {
    return Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
  }

  Future<Position> getInitialLocation() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}

class LocationArgument {
  final String latitude;
  final String longitude;
  final String address;

  LocationArgument(
      {required this.latitude, required this.longitude, required this.address});
}

class MapArgument {
  final LatLng location;
  final bool isUser;
  MapArgument({required this.location, required this.isUser});
}
