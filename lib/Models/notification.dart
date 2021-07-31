class UserNotification {
  String? id;
  List<String>? userIDs;
  String fundraiser;
  String type;
  String content;

  UserNotification({
    this.id,
    this.userIDs,
    required this.fundraiser,
    required this.type,
    required this.content,
  });

  // Parsing the json object to Notification object
  factory UserNotification.fromJson(Map<String, dynamic> data) {
    String id = data['_id'];
    List<String> userIDs = data['userIds'];
    String fundraiser = data['fundraiser'];
    String type = data['type'];
    String content = data['content'];

    return UserNotification(
      userIDs: userIDs,
      fundraiser: fundraiser,
      type: type,
      content: content,
    );
  }

  // Converting Notification object to map format.
  Map<String, dynamic> toJson() {
    return {
      'userIds': userIDs,
      'fundraiser': fundraiser,
      'type': type,
      'content': content,
    };
  }

  // The string representaion of the Notification object.
  @override
  String toString() {
    return 'Notification( userIDs : $userIDs,fundraiser : $fundraiser, type : $toString(),content : $content,)';
  }
}
