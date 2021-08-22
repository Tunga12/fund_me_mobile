import 'dart:convert';

import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  final http.Client httpClient;

  UserDataProvider({
    required this.httpClient,
  });
  UserPreference preference = UserPreference();
  Future<User> getUser(String token, String password) async {
    final response = await httpClient.get(
      Uri.parse(EndPoints.singleUser),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
    );

    if (response.statusCode == 200) {
      final userString = jsonDecode(response.body);
      User user;
      try {
        user = User.fromJson(
          userString,
        );
      } catch (e) {
        throw Exception(e.toString());
      }
      User newUser = user.copyWith(password: password);
      await preference.storeUserInformation(newUser);
      await preference.storeToken(token);
      return user;
    } else {
      throw Exception("${response.body}");
    }
  }

  Future<User> updateUser(User user, String token) async {
    User newUser = user.copyWith(paymentMethods: "telebirr");
    final response = await httpClient.put(
      Uri.parse(EndPoints.singleUser),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      body: jsonEncode(
        newUser.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  // delete user
  Future<String> deleteUser(String token) async {
    final response = await httpClient.delete(
      Uri.parse(EndPoints.singleUser),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
    );

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw Exception(response.body);
    }
  }

  // forgot password Request
  Future<String> forgetPassword(String email) async {
    final response = await httpClient.post(
      Uri.parse(EndPoints.forgotPasswordURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{'email': email},
      ),
    );

    if (response.statusCode == 200) {
      return "deleted";
    } else {
      throw Exception(response.body);
    }
  }

  // reset password request
  Future<User> resetPassword(String password, String userId) async {
    final response = await httpClient.put(
      Uri.parse(EndPoints.resetPasswordURL + userId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{'password': password},
      ),
    );

    if (response.statusCode == 200) {
      return User.fromJson(
        jsonDecode(
          response.body,
        ),
      );
    } else {
      throw Exception(response.body);
    }
  }
}
