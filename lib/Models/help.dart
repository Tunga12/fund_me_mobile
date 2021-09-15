class HelpDataModel {
  String? id;
  String? title;
  String? content;
  String? date;

  HelpDataModel({
    this.id,
    this.content,
    this.title,
    this.date,
  });

  factory HelpDataModel.fromJson(Map<String, dynamic> json) {
    String id = json['_id'];
    String title = json['title'];
    String content = json['content'];
    String date = json['date'];

    return HelpDataModel(
      id: id,
      title: title,
      content: content,
      date: date,
    );
  }

  @override
  String toString() {
    return "HelpModel {id: ${id ?? ""}, title: ${title ?? ""}, content: ${title ?? ""}";
  }
}
