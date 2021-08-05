import 'package:crowd_funding_app/Models/user.dart';

class Member {
  String? id;
  User? userID;
  int? hasRaised;
  int? shareCount;

  Member({
    this.id,
    this.userID,
    this.hasRaised,
    this.shareCount,
  });
  // parsing the json object ot TeamMember object
  factory Member.fromJson(Map<String, dynamic> data) {
    String id = data['_id'];
    int hasRaised = data['hasRaised'];
    int shareCount = data['shareCount'];
    User userId = User.fromJson(data['userId']);

    return Member(
      id: id,
      hasRaised: hasRaised,
      shareCount: shareCount,
      userID: userId,
    );
  }
  // converting The update object to map object
  Map<String, dynamic> toJson() {
    return {
      'userId': userID,
      'hasRaised': hasRaised ?? 0,
      'shareCount': shareCount ?? 0,
    };
  }

  // Converting the TeamMember object to its string representation
  @override
  String toString() {
    return ' TeamMember(userID: $userID,hasRaised: $hasRaised, shareCount: $shareCount,)';
  }
}

class TeamMember {
  String? status;
  Member? member;

  TeamMember({
    this.member,
    this.status,
  });

  factory TeamMember.fromJson(Map<String, dynamic> data) {
    String status = data['status'];
    Map<String, dynamic> id = data['id'];

    return TeamMember(
      status: status,
      member: Member.fromJson(id),
    );
  }

  @override
  String toString() {
    return "TeamMember{status: $status, memeber: $member}";
  }
}
