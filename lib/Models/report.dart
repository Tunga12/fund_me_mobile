class Report {
  String? id;
  String? fundraiserId;
  bool? isDeleted;
  String? reason;
  String? userId;
  String? date;

  Report(
      {this.id,
      this.fundraiserId,
      this.isDeleted,
      this.date,
      this.reason,
      this.userId});

  factory Report.fromJson(Map<String, dynamic> json) {
    String id = json['_id'] ?? "";
    String fundraiserId = json['fundraiserId'];
    bool isDeleted = json['isDeleted'];
    String userId = json['userId'];
    String date = json['date'];

    return Report(
      id: id,
      fundraiserId: fundraiserId,
      isDeleted: isDeleted,
      userId: userId,
      date: date,
    );
  }

  Map<String, dynamic> toJson() {
    return {"reason": id, "fundraiserId": fundraiserId};
  }

  @override
  String toString() {
    return "Report{reason: $reason, fundraiserId: $fundraiserId}";
  }
}
