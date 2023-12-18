import 'dart:convert';

import 'package:chatapp/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> updateAccessToken(String refresh) async {
  http.Response response = await http.post(
      Uri.parse('${Config.domainName}/api/token/refresh/'),
      body: {'refresh': refresh});
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
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('access');

  if (accessToken == null) {
    return false;
  } else {
    bool isLogin = await updateAccessToken(accessToken);
    if (isLogin) {
      return true;
    } else {
      return false;
    }
  }
}
