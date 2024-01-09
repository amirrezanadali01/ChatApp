import 'dart:convert';
import 'dart:ffi';
import 'package:chatapp/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map> getJtwtToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('access');
  final String? refreshToken = prefs.getString('refresh');
  return {'access': accessToken, 'refresh': refreshToken};
}

class JwtTokenApi {
  Future<bool> updateAccessToken() async {
    Map jwtToken = await getJtwtToken();

    http.Response response = await http.post(
        Uri.parse('${Config.domainName}/api/token/refresh/'),
        headers: Hedears.acceptJson,
        body: jsonEncode(<String, String>{'refresh': jwtToken['refresh']!}));

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final JwtTokenModel jwtToken =
          JwtTokenModel.fromJson(jsonDecode(response.body));

      prefs.setString('access', jwtToken.access);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyToken() async {
    Map jwtToken = await getJtwtToken();
    if (jwtToken['access'] == null) {
      return false;
    } else {
      bool isLogin = await updateAccessToken();
      if (isLogin) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> login(username, password) async {
    http.Response response = await http.post(
        Uri.parse('${Config.domainName}/api/token/'),
        headers: Hedears.acceptJson,
        body: jsonEncode(
            <String, String>{"username": username, "password": password}));

    final JwtTokenModel jwtModel =
        JwtTokenModel.fromJson(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access', jwtModel.access);
      prefs.setString('refresh', jwtModel.refresh!);
      return true;
    } else {
      return false;
    }
  }
}

class UserApi {
  Future<List<UserModel>> getTotalUser() async {
    Map jwtToken = await getJtwtToken();
    http.Response response = await http.get(
      Uri.parse('${Config.domainName}/users/total/'),
      headers: <String, String>{
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${jwtToken['access']}',
      },
    );

    return List<UserModel>.from(
        jsonDecode(response.body).map((x) => UserModel.fromJson(x)));
  }
}

class ChatApi {
  Future<List<ChatModel>> getTotalChat(int receiver) async {
    Map jwtToken = await getJtwtToken();
    http.Response response = await http.get(
      Uri.parse('${Config.domainName}/chat/total/$receiver/'),
      headers: <String, String>{
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${jwtToken['access']}',
      },
    );

    return List<ChatModel>.from(
        jsonDecode(response.body).map((x) => ChatModel.fromJson(x)));
  }
}
