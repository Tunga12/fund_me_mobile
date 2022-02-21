import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/total_raised.dart';
import 'package:crowd_funding_app/Models/total_withdraw.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Models/withdrawal.dart';

class Fundraise {
  String? id;
  String? title;
  String? image;
  int? goalAmount;
  String? story;
  Category? category;
  Location? location;
  String? dateCreated;
  User? organizer;
  User? beneficiary;
  List<Donation>? donations;
  List<Update>? updates;
  List<TeamMember>? teams;
  bool? isPublished;
  int? totalSharedCount;
  int? likeCount;
  List<TotalWithdraw>? totalWithdrawal;
  // bool? isDelete;
  TotalRaised? totalRaised;
  List<String>? likedBy;
  Withdrwal? withdrwal;

  Fundraise(
      {this.id,
      this.title,
      this.image,
      this.goalAmount,
      this.story,
      this.category,
      this.location,
      this.dateCreated,
      this.organizer,
      this.beneficiary,
      this.donations,
      this.updates,
      this.teams,
      this.isPublished,
      this.totalSharedCount,
      this.likeCount,
      this.totalRaised,
      this.likedBy,
      this.withdrwal,
      this.totalWithdrawal});

  Fundraise copyWith({
    String? id,
    String? title,
    String? image,
    int? goalAmount,
    String? story,
    Category? category,
    Location? location,
    String? dateCreated,
    User? organizer,
    User? beneficiary,
    List<Donation>? donations,
    List<Update>? updates,
    List<TeamMember>? teams,
    bool? isPublished,
    int? totalSharedCount,
    int? likeCount,
    TotalRaised? totalRaised,
    List<String>? likedBy,
    Withdrwal? withdrwal,
    List<TotalWithdraw>? totalWithdrawal,
  }) {
    return Fundraise(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        goalAmount: goalAmount ?? this.goalAmount,
        story: story ?? this.story,
        category: category ?? this.category,
        location: location ?? this.location,
        dateCreated: dateCreated ?? this.dateCreated,
        organizer: organizer ?? this.organizer,
        beneficiary: beneficiary ?? this.beneficiary,
        donations: donations ?? this.donations,
        updates: updates ?? this.updates,
        teams: teams ?? this.teams,
        isPublished: isPublished ?? this.isPublished,
        totalSharedCount: totalSharedCount ?? this.totalSharedCount,
        likeCount: likeCount ?? this.likeCount,
        totalRaised: totalRaised ?? this.totalRaised,
        likedBy: likedBy ?? this.likedBy,
        withdrwal: withdrwal ?? this.withdrwal,
        totalWithdrawal: totalWithdrawal ?? this.totalWithdrawal);
  }

  // parsing json object to Fundraise object
  factory Fundraise.fromJson(Map<String, dynamic> data) {
    print(data);

    String dateString = data['dateCreated'] ?? '';
    String id = data['_id'] ?? '';
    String title = data['title'] ?? '';
    String image = data['image'] ?? '';
    int goalAmount = data['goalAmount'] ?? 0;
    print("Is integer");
    print(data['totalRaised'] is int);
    print(data['totalRaised']);
    TotalRaised totalRaised = data['totalRaised'] is int
        ? TotalRaised(dollar: 0, birr: data['totalRaised'])
        : TotalRaised.fromJson(data['totalRaised'] ?? {});
    print(totalRaised);
    String story = data['story'] ?? '';
    print("trace 1");
    Category category = data['category'] == null
        ? Category()
        : Category.fromJson(data['category']);
    print("trace 2");
    Location location = data["location"] == null
        ? Location(latitude: "0", longitude: "0")
        : Location.fromJson(data["location"]);
    print("trace 3");
    String dateCreated = data['dateCreated'] ?? '';
    print("trace 4");
    User organizer =
        data['organizer'] == null ? User() : User.fromJson(data['organizer']);
    print("trace 5");
    User beneficiary = data['beneficiary'] == null
        ? User()
        : User.fromJson(data['beneficiary']);
    print('trace 6');
    List donationDynamic = data['donations'] ?? [];
    List updatesDynamic = data['updates'] ?? [];
    List teamsDynamic = data['teams'] ?? [];
    bool isPublished = data['isPublished'] ?? false;
    int totalShareCount = data['totalShareCount'] ?? 0;
    print("trace 7");
    int likeCount = data['likeCount'] ?? 0;
    print("trace 8");
    List likedBy = data['likedBy'] ?? [];
    // bool isDeleted = data['isDeleted'];
    Map<String, dynamic> withdraw = data['withdraw'] ?? {};
    print("trace 9");
    List totalWithdrawal = data['totalWithdraw'] ?? [];
    totalWithdrawal.map((e) => TotalWithdraw.fromJson(e)).toList();
    print("trace 10");

    Fundraise fundraise = Fundraise(
      id: id,
      title: title,
      image: image,
      goalAmount: goalAmount,
      story: story,
      category: category,
      location: location,
      dateCreated: dateCreated,
      organizer: organizer,
      beneficiary: beneficiary,
      donations: donationDynamic.map((e) => Donation.fromJson(e)).toList(),
      updates: updatesDynamic.map((e) => Update.fromJson(e)).toList(),
      teams: teamsDynamic.map((team) => TeamMember.fromJson(team)).toList(),
      isPublished: isPublished,
      totalSharedCount: totalShareCount,
      likeCount: likeCount,
      // isDelete: isDeleted,
      totalRaised: totalRaised,
      likedBy: likedBy.map((e) => e.toString()).toList(),
      withdrwal: Withdrwal.fromJson(withdraw),
      totalWithdrawal:
          totalWithdrawal.map((e) => TotalWithdraw.fromJson(e)).toList(),
    );
    print("fundraise fundraise is ");
    print(fundraise);
    return fundraise;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title ?? "",
      'image': image ?? "",
      'goalAmount': goalAmount ?? 0,
      'story': story ?? "",
      'category': category!.categoryID ?? Category(),
      'location': location ?? Location(latitude: "0", longitude: "0"),
      'organizer': organizer!.id ?? "",
      'beneficiary': beneficiary!.id ?? "",
      'donations': donations ?? [],
      'updates': updates ?? [],
      'teams': teams ?? [],
      'isPublished': isPublished ?? false,
      'totalShareCount': totalSharedCount ?? 0,
      'likeCount': likeCount ?? 0,
      "likedBy": likedBy ?? []
      // 'isDelete': isDelete,
    };
  }

  // string representation of Fundraise object.

  @override
  String toString() {
    return '''Fundraise {title: ${title ?? ""}  ,image: ${image ?? ""},goalAmount: ${goalAmount ?? 0},story: ${story ?? ""},
    category: ${category != null ? category!.categoryID : ""},location: ${location ?? ""},
      dateCreated: ${dateCreated ?? ""},
      organizer: ${organizer != null ? organizer!.id : ""},
      beneficiary: ${beneficiary != null ? beneficiary!.id : ""},
      donations: ${donations ?? []},
      updates: ${updates ?? []},
      teams: ${teams ?? []},
      isPublished: ${isPublished ?? false},
      totalSharedCount: ${totalSharedCount ?? 0},
      likeCount: ${likeCount ?? 0},
      likedBy: ${likedBy ?? []},
      withdraw: $withdrwal
      }''';
  }
}

class Location {
  String longitude;
  String latitude;

  Location({
    required this.longitude,
    required this.latitude,
  });

  // parsing json object to location object
  factory Location.fromJson(Map<String, dynamic> data) {
    print("location data is $data");
    String longitude = data['longitude'];
    String latitude = data['latitude'];

    return Location(
      longitude: longitude,
      latitude: latitude,
    );
  }

  // converting Locaion object ot map object
  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  // string representaion of Location object
  @override
  String toString() {
    return "Location { longitude: $longitude,latitude: $latitude,}";
  }
}

// This class is defined because the fundraise class is not suitable for the home funraises,
class HomeFundraise {
  int? totalItems;
  List<Fundraise>? fundraises;
  int? totalPages;
  int? currentPage;
  bool? hasNextPage;
  bool? hasPreviousPage;

  HomeFundraise({
    this.totalItems,
    this.fundraises,
    this.totalPages,
    this.currentPage,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  // parsing Json object to to HomeFundraise.
  factory HomeFundraise.fromJson(Map<String, dynamic> data) {
    int totalItems = data['totalItems'];
    List fundraisesDynamic = data['fundraisers'];
    int totalPages = data['totalPages'];
    int currentPage = data['currentPage'];
    bool hasNextPage = data['hasNextPage'];
    bool hasPreviousPage = data['hasPrevPage'];

    return HomeFundraise(
      totalItems: totalItems,
      fundraises: fundraisesDynamic
          .map((fundraise) => Fundraise.fromJson(fundraise))
          .toList(),
      totalPages: totalPages,
      currentPage: currentPage,
      hasNextPage: hasNextPage,
      hasPreviousPage: hasPreviousPage,
    );
  }
  // converting HomeFundraise object to json object
  Map<String, dynamic> toJson() {
    return {
      'totalItems': totalItems,
      'fundraises': fundraises,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
    };
  }

  // String format of HomeFundraise object
  @override
  String toString() {
    return '''
      totalItems: $totalItems,
      fundraises: $fundraises
      totalPages: $totalPages,
      currentPage: $currentPage,
      hasNextPage: $hasNextPage,
      hasPreviousPage: $hasPreviousPage
    ''';
  }
}
