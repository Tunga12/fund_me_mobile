import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/withdrawal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
main() {
  group("[HomeFundraise Model]", () {
    HomeFundraise? _homeFundraise;
    setUp(() {
      _homeFundraise = HomeFundraise(
        totalItems: 10,
      );
    });
    // Testing HomeFundraiser model
    test('[HomeFundraise] check individual values', () async {
      _homeFundraise = HomeFundraise(
        currentPage: 1,
        fundraises: [Fundraise(), Fundraise()],
        hasNextPage: false,
        hasPreviousPage: false,
        totalItems: 10,
        totalPages: 1,
      );

      // Begin Test...
      expect(_homeFundraise!.currentPage, 1);
      expect(_homeFundraise!.fundraises, isA<List<Fundraise>>());
      expect(_homeFundraise!.hasNextPage, isFalse);
      expect(_homeFundraise!.hasPreviousPage, isFalse);
      expect(_homeFundraise!.totalItems, 10);
      expect(_homeFundraise!.totalPages, 1);
    });
  });
}
