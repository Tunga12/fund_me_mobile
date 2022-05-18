class TotalRaised {
  double? birr;
  double? dollar;

  TotalRaised({
    required this.dollar,
    required this.birr,
  });

  factory TotalRaised.fromJson(Map<String, dynamic> json) {
    double birr = double.tryParse(json['birr'].toString()) ?? 0;
    double dollar = double.tryParse(json['dollar'].toString()) ?? 0;

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
