import 'dart:io';

import 'package:crowd_funding_app/Models/notification.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<String> getImage(String token, File image) async {
  print('image is');

  Response? response;
  var dio = Dio();
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers['x-auth-token'] = token;
  String fileName = image.path.split('/').last;
  FormData formData = FormData.fromMap({
    'image': await MultipartFile.fromFile(image.path,
        filename: fileName, contentType: new MediaType("image", "jpg")),
  });

  response = await dio.post(
    EndPoints.imageURL,
    data: formData,
  );
  print("status code");
  print(response.statusCode);

  if (response.statusCode! > 200 && response.statusCode! < 250) {
    return response.data;
  } else {
    print('exception image');
    print(response.data);
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

Future<String> getImageTwo(String token, File image) async {
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'x-auth-token': token,
  };
  var stream = new http.ByteStream(image.openRead());
  stream.cast();
  var length = await image.length();
  var request = http.MultipartRequest('POST', Uri.parse(EndPoints.imageURL));
  // String fileName = image.path.split('/').last;
  request.files.add(http.MultipartFile('image', stream, length,
      contentType: MediaType("image", "jpg")));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 201) {
    String image = await response.stream.bytesToString();
    print("image is $image");

    return image;
  } else {
    print("image exception ${response.reasonPhrase}");
    throw Exception(response.reasonPhrase);
  }
}
