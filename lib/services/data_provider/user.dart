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

    print("user get status is ${response.statusCode}");
    print("user get body is  ${response.body}");

    if (response.statusCode == 200) {
      print("user get status 2 is ${response.statusCode}");
      print("user get body is ${response.body}");
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
      print("user form json $user");
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
      print('user update success ${response.statusCode}');
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('user update Error ${response.body}');
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
    print('delete user ${response.statusCode}');
    if (response.statusCode == 200) {
      print("user deleted");
      return jsonDecode(response.body);
    } else {
      print("user delete error ${response.body}");
      throw Exception(response.body);
    }
  }

  // forgot password Request
  Future<bool> forgetPassword(String email) async {
    final response = await httpClient.post(
      Uri.parse(EndPoints.forgotPasswordURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{'email': email},
      ),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
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
