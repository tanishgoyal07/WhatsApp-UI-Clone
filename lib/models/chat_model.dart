class ChatModel {
  String name;
  String message;
  String time;
  bool isGroup;
  String avatarUrl;
  int id;

  ChatModel(
    {required this.name,
    required this.isGroup ,
    required this.message,
    required this.avatarUrl,
    required this.time,
     required this.id}
  );
}

class ContactModel {
  String name;
  String status;
  bool select = false;

  ContactModel(
    {required this.name,
    required this.status,
    this.select = false}
  );
}


