import 'dart:io';

import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

Future<String> getImage(String token, File image) async {
  print("image path is ${image.path}");
  var headers = {
    'x-auth-token': token,
  };

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

  print(response.statusCode);

  if (response.statusCode! > 200 && response.statusCode! < 250) {
    return response.data;
  } else {
    throw Exception(response.data);
  }

  // var request = http.MultipartRequest('POST', Uri.parse(EndPoints.imageURL));
  // request.files.add(await http.MultipartFile.fromPath('image', image.path));
  // request.headers.addAll(headers);
  // var res = await request.send();

  // if (res.statusCode == 201) {
  //   return await res.stream.bytesToString();
  // } else {
  //   print("image upload exception ${res.reasonPhrase}");
  //   print("image upload exception ${res.headers}");
  //   print("image upload exception ${res.statusCode}");
  //   print("image upload exception $res");

  //   throw Exception(res.reasonPhrase);
  // }
}

Future<File?> pickImageFormFile(
    ImageSource imageSource, ImagePicker imagePicker) async {
  XFile? imageFile = await imagePicker.pickImage(source: imageSource);

  if (imageFile == null) return null;
  return File(imageFile.path);
}
