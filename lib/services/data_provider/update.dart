import 'dart:convert';

import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class UpdateDataProvider {
  final http.Client httpClient;
  UpdateDataProvider({
    required this.httpClient,
  });

  Future<Update> createUpdate(Update update, token, String fundraiseId) async {
    print('update $update');
    print('token $token');
    print('fundraise id $fundraiseId');
    final response = await httpClient.post(
      Uri.parse(EndPoints.createUpdate + fundraiseId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      body: jsonEncode(<String, dynamic>{
        "content": update.content,
        "image": update.image,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Update.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        response.body,
      );
    }
  }
}
