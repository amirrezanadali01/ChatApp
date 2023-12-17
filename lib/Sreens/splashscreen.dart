import 'dart:convert';

import 'package:chatapp/Sreens/home.dart';
import 'package:chatapp/Sreens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/models.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> updateAccessToken(String refresh) async {
    http.Response response = await http.post(
        Uri.parse('${Config.domainName}/api/token/refresh/'),
        body: {'refresh': refresh});
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access', jsonDecode(response.body)['access']);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAccessToken() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<bool>(
            future: getAccessToken(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  Future.microtask(() => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home())));
                } else {
                  Future.microtask(() => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login())));
                  // Future.microtask(() => Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Login())));
                }
              }
              return const Text('loading...');
            }),
      ),
    );
  }
}
