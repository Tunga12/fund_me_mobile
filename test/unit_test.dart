// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/auth.dart';
import 'package:crowd_funding_app/services/data_provider/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:crowd_funding_app/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'unit_test.mocks.dart';

const fakeUserResponse = {
  "id": "1234",
  "firstName": "Mock",
  "lastName": "Mock",
};


@GenerateMocks([http.Client])
void main() {
  group("Signup user", () {
    test('returns a user if the http call completes successfully', () async {
      final client = MockClient();
      // final authProvider = AuthDataProvider(httpClient: client);
      final catDataProvider = CategoryDataProvider(httpClient: client);

      when(client.get(
        Uri.parse(EndPoints.categories + "1"),
      )).thenAnswer(
        (_) async => http.Response('{"_id": "123", "name": "mock"}', 200),
      );
      expect(
        await catDataProvider.getSingleCategory("1"),
        isA<Category>(),
      );
    });
  });
}
