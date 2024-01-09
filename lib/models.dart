import 'package:chatapp/Sreens/chat.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static const String domainName = 'http://localhost:8000';
}

class Hedears {
  static const acceptJson = {
    "Accept": "application/json",
    "content-type": "application/json"
  };
}

class JwtTokenModel {
  final String? refresh;
  final String access;

  JwtTokenModel({required this.access, this.refresh});

  factory JwtTokenModel.fromJson(Map json) =>
      JwtTokenModel(access: json['access'], refresh: json['refresh']);
}

class UserModel {
  final String username;
  final int id;
  UserModel({required this.username, required this.id});
  factory UserModel.fromJson(Map json) =>
      UserModel(username: json['username'], id: json['id']);
}

class ChatModel {
  final String text;
  final String date;
  final bool read;
  final int sender;
  final int receiver;

  ChatModel(
      {required this.text,
      required this.date,
      required this.read,
      required this.receiver,
      required this.sender});

  factory ChatModel.fromJson(Map json) => ChatModel(
      text: json['text'],
      date: json['date'],
      read: json['read'],
      receiver: json['receiver'],
      sender: json['sender']);
}
