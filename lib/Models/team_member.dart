import 'package:crowd_funding_app/Models/user.dart';

class TeamMember {
  String? id;
  User? userID;
  int? hasRaised;
  int? shareCount;
  bool? isDeleted;

  TeamMember({
    this.id,
    this.userID,
    this.hasRaised,
    this.shareCount,
    this.isDeleted,
  });
  // parsing the json object ot TeamMember object
  factory TeamMember.fromJson(Map<String, dynamic> data) {
    String id = data['_id'];
    int hasRaised = data['hasRaised'];
    int shareCount = data['shareCount'];
    bool isDeleted = data['isDeleted'];
    User userId = User.fromJson(data['userId']);

    return TeamMember(
      id: id,
      hasRaised: hasRaised,
      shareCount: shareCount,
      isDeleted: isDeleted,
      userID: userId,
    );
  }
  // converting The update object to map object
  Map<String, dynamic> toJson() {
    return {
      'userId': userID,
      'hasRaised': hasRaised ?? 0,
      'shareCount': shareCount ?? 0,
      'isDeleted': isDeleted ?? false,
    };
  }

  // Converting the TeamMember object to its string representation
  @override
  String toString() {
    return ' TeamMember(userID: $userID,hasRaised: $hasRaised, shareCount: $shareCount,)';
  }
}
