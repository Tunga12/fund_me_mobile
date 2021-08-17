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

  Future<String> createUser(User user) async {
    print("user $user");

    final response = await httpClient.post(
      Uri.http('shrouded-bastion-52038.herokuapp.com', '/api/users'),
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
    // print("create status code ${response.body}");
    if (response.statusCode == 201) {
      String token = response.headers['x-auth-token'].toString();
      return token;
    } else {
      print("Error http ${response.body}");
      throw Exception("${response.body}");
    }
  }

  Future<String> signinUser(User user) async {
    print("login user $user");
    final response = await httpClient.post(Uri.parse(EndPoints.loginUser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{"email": user.email, "password": user.password}));
    print("status code ${response.statusCode} ");
    print("body ${response.body}");
    if (response.statusCode == 201) {
      String token = response.headers['x-auth-token'].toString();
      print("login token is $token");
      return token;
    } else {
      throw Exception("${response.body}");
    }
  }
}
