import 'package:chatapp/api_service.dart';
import 'package:chatapp/models.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> get users => _users;
  bool isLoading = false;
  final UserApi userapi = UserApi();

  Future<void> getTotalUser() async {
    isLoading = true;
    notifyListeners();
    await JwtTokenApi().verifyToken();
    _users = await userapi.getTotalUser();
    isLoading = false;
    notifyListeners();
  }
}

class ChatProvider extends ChangeNotifier {
  // final WebSocketChannel _channel = WebSocketChannel.connect(
  //   Uri.parse('ws://localhost:8000/ws/chat/'),
  // );

  List<ChatModel> _chatsTotal = [];
  List<ChatModel> get chatTotal => _chatsTotal;

  bool isLoading = false;
  final ChatApi chatapi = ChatApi();

  Future<void> getTotalChat(int receiver) async {
    isLoading = true;
    notifyListeners();
    await JwtTokenApi().updateAccessToken();
    _chatsTotal = await chatapi.getTotalChat(receiver);
    isLoading = false;
    notifyListeners();
  }
}
