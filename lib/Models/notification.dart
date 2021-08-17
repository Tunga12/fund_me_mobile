class UserNotification {
  String? id;
  String? fundraiser;
  String? type;
  String? title;
  String? content;
  List<String>? viewed;
  List<String>? recipients;
  String? date;

  UserNotification({
    this.id,
    this.fundraiser,
    this.type,
    this.content,
    this.viewed,
    this.recipients,
    this.date,
    this.title,
  });

  // Parsing the json object to Notification object
  factory UserNotification.fromJson(Map<String, dynamic> data) {
    String id = data['_id'];
    String fundraiser = data['target'];
    String type = data['notificationType'];
    String content = data['content'];
    String date = data['date'];
    List viewed = data['viewed'];
    List recipients = data['recipients'];
    String title = data['title'];

    return UserNotification(
      fundraiser: fundraiser,
      type: type,
      content: content,
      title: title,
      date: date,
      viewed: viewed.map((id) => id.toString()).toList(),
      recipients: recipients.map((id) => id.toString()).toList(),
      id: id,
    );
  }

  // Converting Notification object to map format.
  Map<String, dynamic> toJson() {
    return {
      'fundraiser': fundraiser,
      'type': type,
      'content': content,
      'recipients': recipients ?? [],
      'viewed': viewed ?? [],
      'notificationType': type,
      'target': fundraiser,
    };
  }

  // The string representaion of the Notification object.
  @override
  String toString() {
    return 'Notification(fundraiser : $fundraiser, type : $type,content : $content,)';
  }
}
