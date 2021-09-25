class TotalWithdraw {
  String? id;
  String? dateCreated;
  int? amount;

  TotalWithdraw({
    this.id,
    this.amount,
    this.dateCreated,
  });

  factory TotalWithdraw.fromJson(Map<String, dynamic> json) {
    String id = json['_id'];
    String dateCreated = json['dateCreated'];
    int amount = json['amount'];
    return TotalWithdraw(
      id: id,
      amount: amount,
      dateCreated: dateCreated,
    );
  }
}
