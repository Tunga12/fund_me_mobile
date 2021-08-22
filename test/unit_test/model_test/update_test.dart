import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
main() {
  group("[Update Model]", () {
    Update? _update;
    setUp(() {
      _update = Update(content: "Mock Content");
    });

    //Testing Update model
    test('[Update] check individual values', () async {
      _update = Update(
        content: "Mock Content",
        dateCreated: DateTime.now(),
        id: "1234567890l",
        image: "https://shroud",
        isDeleted: false,
        userID: User(),
      );

      //BEGIN TEST...
      expect(_update!.content, "Mock Content");
      expect(_update!.dateCreated, isNotNull);
      expect(_update!.id, startsWith('1234'));
      expect(_update!.image, startsWith("http"));
      expect(_update!.isDeleted, false);
      expect(_update!.userID.runtimeType, equals(User));
    });
  });
}
