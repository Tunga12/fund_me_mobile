import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/update_password_screen.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/auth.dart';
import 'package:crowd_funding_app/services/data_provider/user.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/services/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../unit_test.mocks.dart';
import '../../unit_test/data_provider_test/const_models/mock_user.dart';
import '../common/wrapper.dart';

@GenerateMocks([http.Client])
void main() {
  Provider.debugCheckInvalidValueType = null;

  group("Testing Update password", () {
    MockClient? client;
    UserDataProvider? userDataProvider;
    AuthDataProvider? authDataProvider;

    setUp(() {
      client = MockClient();
      userDataProvider = UserDataProvider(httpClient: client!);
      authDataProvider = AuthDataProvider(httpClient: client!);
    });

    // testing presence of widgets
    testWidgets('Widgets are rendered', (tester) async {
      UpdatePassword updatePassword =
          UpdatePassword(user: mockCompleteUser, token: mockUserToken);

      UserRepository userRepository =
          UserRepository(dataProvider: userDataProvider!);

      await tester.pumpWidget(
        Provider(
          create: (context) => UserModel(userRepository: userRepository),
          child: buildTestableWidget(updatePassword),
        ),
      );

      await tester.pump();
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(Form), findsNWidgets(1));
    });

    // testing empty password credential does not call update password
    testWidgets('empty password credential does not call update password',
        (tester) async {
      UpdatePassword updatePassword =
          UpdatePassword(user: mockCompleteUser, token: mockUserToken);

      UserRepository userRepository =
          UserRepository(dataProvider: userDataProvider!);

      await tester.pumpWidget(
        Provider(
          create: (context) => UserModel(userRepository: userRepository),
          child: buildTestableWidget(updatePassword),
        ),
      );
      await tester.pump();
      Finder formFinder = find.byType(Form);
      Form formWidget = tester.widget(formFinder);
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;

      expect(formKey.currentState!.validate(), isFalse);
    });

    // testing validated form calls update password
    testWidgets('validated form calls update password', (tester) async {
      UpdatePassword updatePassword =
          UpdatePassword(user: mockCompleteUser, token: mockUserToken);

      UserRepository userRepository =
          UserRepository(dataProvider: userDataProvider!);

      await tester.pumpWidget(
        Provider(
          create: (context) => UserModel(userRepository: userRepository),
          child: buildTestableWidget(updatePassword),
        ),
      );

      await tester.pump();

      await tester.enterText(find.byKey(Key('current_password')), '123456789');
      await tester.enterText(find.byKey(Key('new_password')), '123456789');
      await tester.enterText(find.byKey(Key('confirm_password')), '123456789');

      //
      Finder formFinder = find.byType(Form);
      Form formWidget = tester.widget(formFinder);
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;

      //
      formKey.currentState!.save();
      expect(formKey.currentState!.validate(), isTrue);
    });

    //Testing providers
    testWidgets('provider is successful', (tester) async {
      final _providerKey = GlobalKey();
      final _chidlKey = GlobalKey();

      UpdatePassword updatePassword = UpdatePassword(
          key: _chidlKey, user: mockCompleteUser, token: mockUserToken);
      UserRepository userRepository =
          UserRepository(dataProvider: userDataProvider!);

      await tester.pumpWidget(
        Provider(
          key: _providerKey,
          create: (context) => UserModel(userRepository: userRepository),
          child: buildTestableWidget(updatePassword),
        ),
      );

      await tester.pump();
      await tester.enterText(find.byKey(Key('current_password')), '123456789');
      await tester.enterText(find.byKey(Key('new_password')), '123456789');
      await tester.enterText(find.byKey(Key('confirm_password')), '123456789');

      when(
        client!.put(
          Uri.parse(EndPoints.singleUser),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(mockUserJson, 200),
      );

      await tester.tap(find.byKey(Key('save_button')));
      expect(Provider.of<UserModel>(_chidlKey.currentContext!, listen: false),
          isNotNull);
      expect(
          Provider.of<UserModel>(_chidlKey.currentContext!, listen: false)
              .response
              .status,
          ResponseStatus.SUCCESS);
    });
  });
}
