import 'package:chatapp/Sreens/home.dart';
import 'package:chatapp/api_service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  label: Text('Username'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key),
                  label: Text('Password'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                    onPressed: () async {
                      final bool isSuccess = await JwtTokenApi().login(
                          usernameController.text, passwordController.text);

                      if (isSuccess) {
                        if (context.mounted) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        }
                      }
                    },
                    child: const Text('Login')))
          ],
        ),
      ),
    );
  }
}
