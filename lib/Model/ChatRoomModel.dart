// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: file_names

class ChatRoomModel {
  String lastMessage;
  String time;
  List<dynamic> users;

  ChatRoomModel({
    required this.lastMessage,
    required this.time,
    required this.users,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastMessage': lastMessage,
      'time': time,
      'users': users,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      lastMessage: (map["lastMessage"] ?? '') as String,
      time: (map["time"] ?? '') as String,
      users: List<dynamic>.from(
        ((map['users'] ?? const <dynamic>[]) as List<dynamic>),
      ),
    );
  }
}
