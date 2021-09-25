class Withdrwal {
  String? id;
  final String bankName;
  final String bankAccountNo;
  final bool isOrganizer;
  String? status;
  bool? isDeleted;
  String? dateTime;

  Withdrwal({
    this.id,
    required this.bankName,
    required this.bankAccountNo,
    required this.isOrganizer,
    this.status,
    this.isDeleted,
    this.dateTime,
  });

  factory Withdrwal.fromJson(Map<String, dynamic> data) {
    String id = data['_id'] ?? '';
    String status = data['status'] ?? '';
    String bankName = data['bankName'] ?? '';
    String bankAccountNo = data['bankAccountNo'] ?? '';
    bool isOrganizer = data['isOrganizer'] ?? false;
    String dateTime = data['date'] ?? DateTime.now().toString();
    bool isDeleted = data['isDeleted'] ?? false;

    return Withdrwal(
        bankAccountNo: bankAccountNo,
        id: id,
        status: status,
        bankName: bankName,
        isOrganizer: isOrganizer,
        isDeleted: isDeleted,
        dateTime: dateTime);
  }
}
