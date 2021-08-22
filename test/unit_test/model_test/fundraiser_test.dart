import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
main() {
  group("[Fundraiser Model]", () {
    Fundraise? _fundraiseModel;
    setUp(() {
      _fundraiseModel = Fundraise(title: "Mock Fundraiser");
    });

    // Testing Fundraiser model
    test('[Model] check individual values', () async {
      _fundraiseModel = Fundraise(
          title: "Mock Fundraiser",
          beneficiary:
              User(firstName: "MockFirstName", lastName: "MockLastName"),
          organizer: User(firstName: "MockFirstName", lastName: "MockLastName"),
          category: Category(
              categoryID: "123456789p", categoryName: "Mock Fundraiser"),
          dateCreated: DateTime.now(),
          donations: [Donation(amount: 30, tip: 1.3, comment: "Mock Comment")],
          goalAmount: 1235,
          id: "123456789l",
          image: 'https://shroud',
          isPublished: false,
          likeCount: 123,
          likedBy: ['123456789', "123456789"],
          location: Location(latitude: '8.56', longitude: '38.7'),
          story: "Mock Story",
          teams: [TeamMember(member: Member(id: "12345"))],
          totalRaised: 23,
          totalSharedCount: 12,
          updates: [Update(content: "Mock content")]);

      // BEGIN TEST...
      expect(_fundraiseModel!.beneficiary.runtimeType, equals(User));
      expect(_fundraiseModel!.organizer.runtimeType, equals(User));
      expect(_fundraiseModel!.title, 'Mock Fundraiser');
      expect(_fundraiseModel!.organizer.runtimeType, equals(User));
      expect(_fundraiseModel!.dateCreated, isNotNull);
      expect(_fundraiseModel!.donations, isA<List<Donation>>());
      expect(_fundraiseModel!.goalAmount, 1235);
      expect(_fundraiseModel!.id, isNotEmpty);
      expect(_fundraiseModel!.image, startsWith('http'));
      expect(_fundraiseModel!.isPublished, false);
      expect(_fundraiseModel!.likeCount, 123);
      expect(_fundraiseModel!.likedBy, isA<List<String>>());
      expect(_fundraiseModel!.location, isA<Location>());
      expect(_fundraiseModel!.story, "Mock Story");
      expect(_fundraiseModel!.teams, isA<List<TeamMember>>());
      expect(_fundraiseModel!.totalRaised, 23);
      expect(_fundraiseModel!.totalSharedCount, 12);
      expect(_fundraiseModel!.updates, isA<List<Update>>());

      
    });
  });
}
