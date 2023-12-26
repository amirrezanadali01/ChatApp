import 'package:flutter/material.dart';

class Config {
  static const String domainName = 'http://192.168.1.102:8000';
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
  UserModel({required this.username});
  factory UserModel.fromJson(Map json) => UserModel(username: json['username']);
}
