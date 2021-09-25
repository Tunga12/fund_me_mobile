class ReportReason {
  String? id;
  String? name;

  ReportReason({
    this.id,
    this.name,
  });

  factory ReportReason.fromJson(Map<String, dynamic> json) {
    String id = json['_id'];
    String name = json['name'];

    // report
    return ReportReason(
      id: id,
      name: name,
    );
  }

  @override
  String toString() {
    
    return """ReportReason{id: $id, name: $name}""";
  }
}
