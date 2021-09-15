import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const_models/mock_user.dart';

class MockSharedPreferences extends Mock implements UserPreference {}

// globals.dart
Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

@GenerateMocks([http.Client])
void main() {
  // test('shared preference knows user', () async {
  //   PreferenceData preferenceData =
  //       PreferenceData(data: mockCompleteUser, status: true);
  //   UserPreference userPreference = UserPreference();
  //   final mockUserPreference = MockSharedPreferences();
  //   when(mockUserPreference.getUserInfromation()).thenAnswer((_) async =>
  //       Future.delayed(
  //           const Duration(milliseconds: 100), () => preferenceData));
  //   when(() => mockUserPreference.getUserInfromation())
  //       .thenAnswer((_) async => getPreferedData());
  //   PreferenceData userPreferenceData =
  //   expect(await userPreference.getUserInfromation(), isA<PreferenceData>());
  // });
}


