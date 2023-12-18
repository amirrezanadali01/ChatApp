import 'package:chatapp/Sreens/home.dart';
import 'package:chatapp/Sreens/login.dart';
import 'package:chatapp/api_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<bool>(
            future: verifyToken(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  Future.microtask(() => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home())));
                } else {
                  Future.microtask(() => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login())));
                }
              }
              return const Text('loading...');
            }),
      ),
    );
  }
}
