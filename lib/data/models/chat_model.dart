// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    this.isUser,
    this.message,
    this.timestamp,
  });

  bool isUser;
  String message;
  String timestamp;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        isUser: json["is_user"],
        message: json["message"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "is_user": isUser,
        "message": message,
        "timestamp": timestamp,
      };
}
