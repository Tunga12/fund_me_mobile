import 'package:crowd_funding_app/Models/user.dart';

class Withdrwal {
  String? id;
  final String bankName;
  final String bankAccountNo;
  final bool isOrganizer;
  final String beneficiary;
  String? status;
  bool? isDeleted;
  DateTime? dateTime;

  Withdrwal({
    this.id,
    required this.bankName,
    required this.bankAccountNo,
    required this.isOrganizer,
    required this.beneficiary,
    this.status,
    this.isDeleted,
    this.dateTime,
  });
  factory Withdrwal.fromJson(Map<String, dynamic> data) {
    String id = data['_id'];
    String status = data['status'];
    String bankName = data['bankName'];
    String bankAccountNo = data['bankAccountNo'];
    bool isOrganizer = data['isOrganizer'];
    Map<String, dynamic> beneficiaryString = data['beneficiary'];
    String dateTime = data['date'];
    bool isDeleted = data['isDeleted'];

    return Withdrwal(
        bankAccountNo: bankAccountNo,
        id: id,
        status: status,
        bankName: bankName,
        isOrganizer: isOrganizer,
        beneficiary: User.fromJson(beneficiaryString).id!,
        isDeleted: isDeleted,
        dateTime: DateTime.parse(dateTime));
  }
}

class Withdraw {
  Withdrwal id;
  String beneficiary;

  Withdraw({
    required this.beneficiary,
    required this.id,
  });

  factory Withdraw.fromJson(Map<String, dynamic> data) {
    Map<String, dynamic> id = data['id'];
    String beneficiary = data['beneficiary'];

    return Withdraw(
      beneficiary: beneficiary,
      id: Withdrwal.fromJson(id),
    );
  }

  @override
  String toString() {
    return "Withdrawal{id: $id, beneficiary: $beneficiary}";
  }
}
