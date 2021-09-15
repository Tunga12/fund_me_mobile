import 'package:crowd_funding_app/Screens/account_settings.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/data_provider/user.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/services/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../unit_test.mocks.dart';
import '../../unit_test/data_provider_test/const_models/mock_user.dart';
import '../common/wrapper.dart';

@GenerateMocks([http.Client])
void main() {
  group("Testing home body", () {
    MockClient? client;
    UserDataProvider? _userDataProvider;
    setUp(() {
      client = MockClient();
      _userDataProvider = UserDataProvider(httpClient: client!);
    });

    test('User preference', () async {
      SharedPreferences.setMockInitialValues({});
      UserPreference userPreference = UserPreference();
      userPreference.storeUserInformation(mockCompleteUser);
      PreferenceData tokenPreferenceData = await userPreference.getUserToken();
      PreferenceData userPreferenceData =
          await userPreference.getUserInfromation();
          
      print(userPreferenceData.data);

      expect(userPreferenceData.data, isNull);
      expect(tokenPreferenceData.data, isNull);

      

    });

    // testing if empty user credential calls save
    testWidgets('Empty user credential doesnot call save', (tester) async {
      final _providerKey = GlobalKey();
      final _childKey = GlobalKey();
      BuildContext? buildContext;
      UserRepository _userRepository =
          UserRepository(dataProvider: _userDataProvider!);

      await tester.pumpWidget(
        ChangeNotifierProvider<UserModel>(
          key: _providerKey,
          create: (context) {
            buildContext = context;
            return UserModel(
              userRepository: _userRepository,
            );
          },
          child: buildTestableWidget(
            AccountSettings(
              key: _childKey,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(minutes: 1));
      Finder _firstNameFinder = find.byKey(Key("first_name"));
      Finder _lastNameFinder = find.byKey(Key('last_name'));
      Finder _emailFinder = find.byKey(Key('email'));
      Finder _password = find.byKey(Key('password'));
      Finder _formFinder = find.byType(Form);

      expect(_firstNameFinder, findsNothing);

      // Form formWidget = tester.widget(_formFinder) as Form;
      // GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      // expect(formKey.currentState!.validate(), isTrue);
    });
  });
}
