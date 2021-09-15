import 'dart:async';
import 'dart:convert';

import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class AuthDataProvider {
  final http.Client httpClient;
  AuthDataProvider({
    required this.httpClient,
    // required this.preference,
  });
// Uri.http('shrouded-bastion-52038.herokuapp.com', '/api/users'),
  Future<String> createUser(User user) async {
    final response = await httpClient.post(
      Uri.parse(EndPoints.registerUser),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'firstName': user.firstName,
          'lastName': user.lastName,
          'email': user.email,
          'password': user.password,
          'phoneNumber': user.phoneNumber,
        },
      ),
    );

    if (response.statusCode == 201) {
      String token = response.headers['x-auth-token'].toString();
      return token;
    } else {
      throw Exception("${response.body}");
    }
  }

  Future<String> signinUser(User user) async {
    final response = await httpClient.post(Uri.parse(EndPoints.loginUser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{"email": user.email, "password": user.password}));
    if (response.statusCode == 201) {
      String token = response.headers['x-auth-token'].toString();
      return token;
    } else {
      throw Exception("${response.body}");
    }
  }
}
