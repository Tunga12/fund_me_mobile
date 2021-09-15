import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/forgot_password.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/data_provider/auth.dart';
import 'package:crowd_funding_app/services/data_provider/user.dart';
import 'package:crowd_funding_app/services/provider/auth.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/services/repository/auth.dart';
import 'package:crowd_funding_app/services/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../unit_test.mocks.dart';
import '../../unit_test/data_provider_test/const_models/mock_user.dart';
import '../common/wrapper.dart';

class MockUserProvider extends Mock implements UserModel {}

class MockSharedPreference extends Mock implements SharedPreferences {}

@GenerateMocks([http.Client])
void main() {
  group("Testing Forgot password", () {
    MockClient? client;
    UserDataProvider? userDataProvider;
    AuthDataProvider? authDataProvider;

    setUp(() {
      client = MockClient();
      userDataProvider = UserDataProvider(httpClient: client!);
      authDataProvider = AuthDataProvider(httpClient: client!);
    });

    // Testing components available
    testWidgets('Testing components of forgot password', (tester) async {
      ForgotPassword forgotPassword = ForgotPassword(url: mockId);
      await tester.pumpWidget(buildTestableWidget(forgotPassword));
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byKey(Key('forgot_password')), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
    });

    // Testing empty password doesnot call forgot password
    testWidgets('Empty password doesnot call forgot password', (tester) async {
      ForgotPassword forgotPassword = ForgotPassword(url: mockId);
      await tester.pumpWidget(buildTestableWidget(forgotPassword));

      Finder formFinder = find.byType(Form);
      Form formWidget = tester.widget(formFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;

      expect(formKey.currentState!.validate(), isFalse);
    });

    // Testing validated form calls forgot password
    testWidgets('validated form calls forgot passsword', (tester) async {
      ForgotPassword forgotPassword = ForgotPassword(url: mockId);
      await tester.pumpWidget(buildTestableWidget(forgotPassword));

      Finder newPasswordFinder = find.byKey(Key('new_password'));
      Finder confirmPasswordFinder = find.byKey(Key('confirm_password'));
      // expect(actual, matcher)
      await tester.enterText(newPasswordFinder, '123456789');
      await tester.enterText(confirmPasswordFinder, '123456789');

      TextFormField textFormField =
          tester.widget(newPasswordFinder) as TextFormField;

      Finder formFinder = find.byType(Form);
      Form formWidget = tester.widget(formFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      formKey.currentState!.save();
      expect(formKey.currentState!.validate(), isTrue);
    });

    // Testing Provider
    testWidgets("Testing provider", (tester) async {
      final _providerKey = GlobalKey();
      final _childKey = GlobalKey();
      AuthRepository authRepository =
          AuthRepository(dataProvider: authDataProvider!);
      UserRepository userRepository =
          UserRepository(dataProvider: userDataProvider!);
      ForgotPassword forgotPassword =
          ForgotPassword(key: _childKey, url: mockId);

      await tester.pumpWidget(
        buildTestableWidget(
          MultiProvider(
            key: _providerKey,
            providers: [
              ChangeNotifierProvider(
                create: (context) => AuthModel(authRepository: authRepository),
              ),
              ChangeNotifierProvider(
                create: (context) => UserModel(userRepository: userRepository),
              )
            ],
            child: forgotPassword,
          ),
        ),
      );

      await tester.pump();
      when(
        client!.put(Uri.parse(EndPoints.resetPasswordURL + mockId),
            body: anyNamed('body'), headers: anyNamed('headers')),
      ).thenAnswer((_) async => http.Response(mockUserJson, 200));

      when(
        client!
            .get(Uri.parse(EndPoints.singleUser), headers: anyNamed('headers')),
      ).thenAnswer((_) async => http.Response(mockUserJson, 200));

      when(
        client!.post(Uri.parse(EndPoints.loginUser),
            body: anyNamed('body'), headers: anyNamed('headers')),
      ).thenAnswer((_) async =>
          http.Response('', 201, headers: {'x-auth-token': mockUserToken}));

      // final _mockSharedPreference = MockSharedPreference();


      // when(_mockSharedPreference.storeUserInformation(mockCompleteUser))
      //     .thenAnswer((_) async => Future.value());

      Finder newPasswordFinder = find.byKey(Key('new_password'));
      Finder confirmPasswordFinder = find.byKey(Key('confirm_password'));
      // expect(actual, matcher)
      await tester.enterText(newPasswordFinder, '123456789');
      await tester.enterText(confirmPasswordFinder, '123456789');

      Finder forgotPasswordButton = find.byKey(Key('forgot_password'));
      await tester.tap(forgotPasswordButton);
      expect(Provider.of<AuthModel>(_childKey.currentContext!, listen: false),
          isNotNull);
      expect(Provider.of<UserModel>(_childKey.currentContext!, listen: false),
          isNotNull);
      print("provider data");
      print('Loggedin status');
      print(
        Provider.of<AuthModel>(_childKey.currentContext!, listen: false)
            .signinStatus,
      );
      print('users status');
      print(
        Provider.of<UserModel>(_childKey.currentContext!, listen: false)
            .response
            .status,
      );
      expect(
          Provider.of<AuthModel>(_childKey.currentContext!, listen: false)
              .signinStatus,
          AuthStatus.LOGGEDIN);
      expect(
          Provider.of<UserModel>(_childKey.currentContext!, listen: false)
              .response
              .status,
          ResponseStatus.LOADING);
      expect(
          Provider.of<AuthModel>(_childKey.currentContext!, listen: false)
              .signinStatus,
          AuthStatus.LOGGEDIN);

      // expect(find.text('Error'), findsOneWidget);
    });
  });
}
