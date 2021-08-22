import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
main() {
  group("[Location Model]", () {
    Location? _location;
    setUp(() {
      _location = Location(
        longitude: "8.23",
        latitude: '40.96',
      );
    });
      // Testing Location model
      test('[Location] check individual values', () async {
        // Begin Testing...
       
        expect(_location!.latitude.runtimeType, equals(String));
        expect(_location!.longitude, isNotEmpty);
      });
    });

}
