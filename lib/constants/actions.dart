import 'dart:io';

import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

Future<String> getImage(String token, File image) async {
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
