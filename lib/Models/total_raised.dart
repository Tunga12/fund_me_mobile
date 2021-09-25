class TotalRaised {
  int? birr;
  int? dollar;

  TotalRaised({
    required this.dollar,
    required this.birr,
  });

  factory TotalRaised.fromJson(Map<String, dynamic> json) {
    int birr = json['birr'] ?? 0;
    int dollar = json['dollar'] ?? 0;

    return TotalRaised(
      dollar: dollar,
      birr: birr,
    );
  }

  @override
  String toString() {
    return 'TotalRaised{birr: $birr, dollar: $dollar}';
  }
}
