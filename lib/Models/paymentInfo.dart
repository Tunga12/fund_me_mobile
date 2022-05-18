class PaymentInfo {
  String? id;
  String? name;
  int? shortcodeTelebirr;
  String? appIdTelebirr;

  String? appKeyTelebirr;
  bool? isDeleted;

  PaymentInfo(
      {this.id,
      this.name,
      this.shortcodeTelebirr,
      this.appIdTelebirr,
      this.appKeyTelebirr});

  factory PaymentInfo.fromJson(Map<String, dynamic> data) {
    print("paymentInfo data is $data");
    String id = data['_id'] ?? '';
    String name = data['name'] ?? '';
    int shortcodeTelebirr = data['shortcodeTelebirr'] ?? 0;
    String appIdTelebirr = data['appIdTelebirr'] ?? '';

    String appKeyTelebirr = data['appKeyTelebirr'] ?? '';

    return PaymentInfo(
      id: id,
      name: name,
      shortcodeTelebirr: shortcodeTelebirr,
      appIdTelebirr: appIdTelebirr,
      appKeyTelebirr: appKeyTelebirr,
    );
  }
}
