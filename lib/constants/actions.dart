import 'dart:io';
import 'package:crowd_funding_app/Models/notification.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/constants/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mime/mime.dart';

Future<String> getImage(String token, File image) async {
  print('image is');
  final mimeType = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');
  int length = await image.length();
  Response? response;
  var dio = Dio();
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers['x-auth-token'] = token;
  String fileName = image.path.split('/').last;
  FormData formData = FormData.fromMap({
    
    'image': await MultipartFile.fromFile(image.path,
        filename: fileName, contentType: MediaType(mimeType![0], mimeType[1])),
  });

  response = await dio.post(
    EndPoints.imageURL,
    data: formData,
  );
 

  if (response.statusCode! > 200 && response.statusCode! < 250) {
    return response.data;
  } else {
 
    throw Exception(response.data);
  }
}

Future<File?> pickImageFormFile(
    ImageSource imageSource, ImagePicker imagePicker) async {
  XFile? imageFile = await imagePicker.pickImage(source: imageSource);

  if (imageFile == null) return null;
  return File(imageFile.path);
}

List<UserNotification> filterViewedNotifications(
    List<UserNotification> notifications, String userId) {
  List<UserNotification> _filteredUserNotifications = [];
  List<UserNotification> _viewed = [];

  notifications.forEach((notification) {
    _filteredUserNotifications.insert(0, notification);
  });

  _filteredUserNotifications.addAll(_viewed);

  return _filteredUserNotifications;
}

int unviewedNotifications(List<UserNotification> notifications, String userId) {
  int _totalUnviewedNotifications = 0;
  notifications.forEach((notification) {
    if (!notification.viewed!.contains(userId)) {
      _totalUnviewedNotifications++;
    }
  });
  return _totalUnviewedNotifications;
}

Future<File?> cropImage(File image) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets:  [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                // CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9,
              ]
            ,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor:  Colors.green
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile == null) return null;
    return croppedFile;
    
  }


bool isBigger(File image){
  return image.lengthSync() / (1024 * 1024) > 0.1;
}