import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/services/data_provider/auth.dart';
import 'package:crowd_funding_app/services/provider/auth.dart';
import 'package:crowd_funding_app/services/repository/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../unit_test.mocks.dart';
import '../common/wrapper.dart';

class AuthMock {
  String? token;
  AuthMock({this.token});

  bool didRequestSignIn = false;
  bool didRequestCreateUser = false;
  bool didRequestLogout = false;

  Future<String> signIn(String email, String password) async {
    didRequestSignIn = true;
    return _userIdOrError();
  }

  Future<String> createUser(String email, String password) async {
    didRequestCreateUser = true;
    return _userIdOrError();
  }

  Future<String> currentUser() async {
    return _userIdOrError();
  }

  Future<void> signOut() async {
    didRequestLogout = true;
    return Future.value();
  }

  Future<String> _userIdOrError() {
    if (token != null) {
      return Future.value(token);
    } else {
      throw StateError('No user');
    }
  }
}

@GenerateMocks([http.Client])
void main() {
  group("Testing signin in", () {
    MockClient? client;
    setUp(() {
      client = MockClient();
    });
    testWidgets('Testing signin page', (WidgetTester tester) async {
      SigninPage signinPage = SigninPage();
      final _providerKey = GlobalKey();

      AuthRepository authRepository =
          AuthRepository(dataProvider: AuthDataProvider(httpClient: client!));

      await tester.pumpWidget(
        ChangeNotifierProvider(
          key: _providerKey,
          create: (context) => AuthModel(
            authRepository: authRepository,
          ),
          child: buildTestableWidget(signinPage),
        ),
      );

      final textFormField = find.byType(TextFormField);
      final signinButton = find.byKey(Key('signinbutton_key'));

      expect(textFormField, findsNWidgets(2));
      expect(signinButton, findsOneWidget);
    });

    // Testing sigin in when email and password is empty.
    testWidgets('empty email and password doesn\'t call sign in',
        (WidgetTester tester) async {
      SigninPage signinPage = SigninPage();
      final _providerKey = GlobalKey();
      AuthRepository authRepository =
          AuthRepository(dataProvider: AuthDataProvider(httpClient: client!));
      await tester.pumpWidget(
        ChangeNotifierProvider(
          key: _providerKey,
          create: (context) => AuthModel(
            authRepository: authRepository,
          ),
          child: buildTestableWidget(signinPage),
        ),
      );

      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState!.validate(), isFalse);
    });

    // Testing signin when email and password not empty

    testWidgets('email and password filled ok', (WidgetTester tester) async {
      SigninPage signinPage = SigninPage();
      final _providerKey = GlobalKey();
      AuthRepository authRepository =
          AuthRepository(dataProvider: AuthDataProvider(httpClient: client!));
      await tester.pumpWidget(
        ChangeNotifierProvider(
          key: _providerKey,
          create: (context) => AuthModel(
            authRepository: authRepository,
          ),
          child: buildTestableWidget(signinPage),
        ),
      );

      Finder signinButtonFinder = find.byKey(Key('signinbutton_key'));
      Finder emailFinder = find.byKey(Key('email_formfield'));
      Finder passwordFinder = find.byKey(Key('password_formfield'));

      await tester.enterText(emailFinder, 'abex@gmail.com');
      await tester.enterText(passwordFinder, "123456789");
      await tester.pump();
      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState!.validate(), isTrue);
    });
  });
}
