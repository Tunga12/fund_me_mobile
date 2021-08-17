import 'dart:convert';
import 'dart:io';

import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/constants/actions.dart';
import 'package:http/http.dart' as http;

class UpdateDataProvider {
  final http.Client httpClient;
  UpdateDataProvider({
    required this.httpClient,
  });

  Future<bool> createUpdate(Update update, token, String fundraiseId,
      {File? image}) async {
    print('update $update');
    print('Update body ');
    print('fundraise id $fundraiseId');
    http.Response? response;
    image == null
        ? response = await httpClient.post(
            Uri.parse(EndPoints.createUpdate + fundraiseId),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token,
            },
            body: jsonEncode(<String, dynamic>{
              "content": update.content,
            }),
          )
        : await getImage(token, image).then((imageResponse) async {
            response = await httpClient.post(
              Uri.parse(EndPoints.createUpdate + fundraiseId),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': token,
              },
              body: jsonEncode(<String, dynamic>{
                "content": update.content,
                "image":imageResponse
               
              }),
            );
          });
    print(response!.statusCode);
    if (response!.statusCode == 201) {
      return true;
    } else {
      throw Exception(
        response!.body,
      );
    }
  }
  Future<bool> deleteUpdate(String updateId, String token) async {
    final response = await httpClient.delete(
      Uri.parse(EndPoints.createUpdate + updateId),
      headers: <String, String>{
        "Content-Type": "application/json charset=UTF-8",
        "x-auth-token": token
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("unable to delete update");
    }
  }
}
