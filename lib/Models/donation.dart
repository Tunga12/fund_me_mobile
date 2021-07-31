import 'package:crowd_funding_app/Models/user.dart';

class Donation {
  String? id;
  User? userID;
  String? memberID;
  int? amount;
  String? comment;
  DateTime? date;
  bool? isDeleted;

  Donation(
      {this.id,
      this.userID,
      this.memberID,
      this.amount,
      this.comment,
      this.date,
      this.isDeleted});

  factory Donation.fromJson(Map<String, dynamic> data) {
    String id = data['_id'] ?? "";
    User userID =
        data['userId'] == null ? User() : User.fromJson(data['userId']);
    String memberID = data['memberId'] ?? "";
    int amount = data['amount'] ?? 0;
    String comment = data['comment'] ?? "";
    String dateString = data['date'] ?? "";
    bool isDeleted = data['isDeleted'] ?? false;

    DateTime date = DateTime.parse(dateString);

    return Donation(
        id: id,
        userID: userID,
        memberID: memberID,
        amount: amount,
        comment: comment,
        date: date,
        isDeleted: isDeleted);
  }
  // factory Donation.fromJson2(Map<String, dynamic> data) {
  //   print("donationsData $data");
  //   String id = data['_id'];
  //   String dateString = data['date'];
  //   DateTime date = DateTime.parse(dateString);

  //   return Donation(
  //     id: id,
  //     date: date,
  //   );
  // }

  // To convert Donation object to map
  Map<String, dynamic> toJson() {
    return {
      'userId': userID,
      'memberId': memberID,
      'amount': amount,
      'comment': comment,
      'date': date,
      'isDeleted': isDeleted,
    };
  }

  @override
  String toString() {
    return '''
            userID: $amount,
            memberID: $memberID,
            amount: $amount,
            comment: $comment,
            date: $date,
        ''';
  }
}
