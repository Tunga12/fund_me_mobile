import 'package:crowd_funding_app/Models/user.dart';

class Donation {
  String? id;
  User? userID;
  String? memberID;
  int? amount;
  String? comment;
  String? date;
  bool? isDeleted;
  double? tip;
  bool? isAnonymous;
  String? paymentMethod;

  Donation(
      {this.id,
      this.userID,
      this.memberID,
      this.amount,
      this.comment,
      this.tip,
      this.date,
      this.isAnonymous,
      this.isDeleted,
      this.paymentMethod});

  factory Donation.fromJson(Map<String, dynamic> data) {
    
    
    String id = data['_id'] ?? "";
    User userID =
        data['userId'] == null ? User() : User.fromJson(data['userId']);
    String memberID = data['memberId'] ?? "";
    int amount = data['amount'] ?? 0;
    String comment = data['comment'] ?? "";
    String dateString = data['date'] ?? "";
    bool isDeleted = data['isDeleted'] ?? false;
    bool isAnonymous = data['isAnonymous'] ?? false;
    String paymentMethod = data['paymentMethod'] ?? "";

    

    return Donation(
        id: id,
        userID: userID,
        memberID: memberID,
        amount: amount,
        comment: comment,
        date: dateString,
        isDeleted: isDeleted,
        isAnonymous: isAnonymous,
        paymentMethod: paymentMethod);
  }

  // To convert Donation object to map
  Map<String, dynamic> toJson() {
    return {
      'userId': userID!.id ?? "",
      'memberId': memberID ?? "",
      'amount': amount ?? 0,
      'comment': comment ?? "",
      'tip': tip ?? 0.0,
    };
  }

  @override
  String toString() {
    return '''
           Donation{
             isAnonymous: $isAnonymous
              userId: ${userID!.id},
            memberId: $memberID,
            amount: $amount,
            comment: $comment,
            date: $date,
            'tip': $tip,
            paymentMethod:$paymentMethod
           }
        ''';
  }
}
