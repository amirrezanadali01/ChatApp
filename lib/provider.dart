import 'package:chatapp/api_service.dart';
import 'package:chatapp/models.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> get users => _users;
  bool isLoading = false;
  final UserApi userapi = UserApi();

  Future<void> getTotalUser() async {
    isLoading = true;
    notifyListeners();
    _users = await userapi.getTotalUser();
    isLoading = false;
    notifyListeners();
  }
}
