import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../../unit_test.mocks.dart';


@GenerateMocks([Dio])
main() {
  group('Testing Image upload', () {
    MockClient? client;
    final formData = FormData.fromMap({
      'image':""
    });
    setUp(() {
      client = MockClient();
    });

    // Test getImage when succesfully completed
    test("getImage return a url image string when completed completed", () {
      // when(client.post());
    });
  });
}
