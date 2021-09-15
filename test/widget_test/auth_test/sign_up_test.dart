import 'package:crowd_funding_app/Screens/signup_page.dart';
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

@GenerateMocks([http.Client])
void main() {
  group("Testing signup page", () {
    MockClient? client;
    setUp(() {
      client = MockClient();
    });

    testWidgets('Testing signup page', (WidgetTester tester) async {
      SignupPage signupPage = SignupPage();
      final _providerKey = GlobalKey();
      AuthRepository authRepository =
          AuthRepository(dataProvider: AuthDataProvider(httpClient: client!));

      await tester.pumpWidget(
        ChangeNotifierProvider(
          key: _providerKey,
          create: (context) => AuthModel(
            authRepository: authRepository,
          ),
          child: buildTestableWidget(signupPage),
        ),
      );

      final textFormField = find.byType(TextFormField);
      final signupButton = find.byType(TextButton);
      final signupButtonByKey = find.byKey(Key('signup_button'));

      // testing components
      expect(textFormField, findsNWidgets(6));
      expect(signupButton, findsNWidgets(1));
      expect(signupButtonByKey, findsOneWidget);
    });
    // Testing sigin in when email and password is empty.
    testWidgets('Empty user credentials does not call signup',
        (WidgetTester tester) async {
      SignupPage signupPage = SignupPage();
      final _providerKey = GlobalKey();
      AuthRepository authRepository =
          AuthRepository(dataProvider: AuthDataProvider(httpClient: client!));
      await tester.pumpWidget(
        ChangeNotifierProvider(
          key: _providerKey,
          create: (context) => AuthModel(
            authRepository: authRepository,
          ),
          child: buildTestableWidget(signupPage),
        ),
      );

      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState!.validate(), isFalse);
    });
    testWidgets('user credential OK calls signup', (WidgetTester tester) async {
      SignupPage signupPage = SignupPage();
      final _providerKey = GlobalKey();
      AuthRepository authRepository =
          AuthRepository(dataProvider: AuthDataProvider(httpClient: client!));
      await tester.pumpWidget(
        ChangeNotifierProvider(
          key: _providerKey,
          create: (context) => AuthModel(
            authRepository: authRepository,
          ),
          child: buildTestableWidget(signupPage),
        ),
      );

      Finder signinButtonFinder = find.byKey(Key('signup_button'));
      Finder emailFinder = find.byKey(Key('signup_email'));
      Finder passwordFinder = find.byKey(Key('signup_password'));
      Finder firstNameFider = find.byKey(Key('signup_firstname'));
      Finder lastNameFinder = find.byKey(Key("signup_lastname"));
      Finder phoneNumberFinder = find.byKey(Key('signup_phonenumber'));
      Finder confirmPasswordFinder = find.byKey(Key('signup_confirmpassword'));

      await tester.enterText(emailFinder, 'sasr@gmail.com');
      await tester.enterText(passwordFinder, '123456789');
      await tester.enterText(firstNameFider, 'sasr');
      await tester.enterText(lastNameFinder, 'gasr');
      await tester.enterText(phoneNumberFinder, '0911223344');
      await tester.enterText(confirmPasswordFinder, '123456789');

      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState!.validate(), isTrue);
    });

    // Testing provider 
    
  });
}
