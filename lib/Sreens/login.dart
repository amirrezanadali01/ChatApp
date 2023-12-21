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
            LoginInput(
              controller: usernameController,
            ),
            const SizedBox(height: 30),
            LoginInput(controller: passwordController, isPassword: true),
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

class LoginInput extends StatelessWidget {
  const LoginInput({
    super.key,
    required this.controller,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        obscureText: isPassword == true ? true : false,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(isPassword == true ? Icons.key : Icons.person),
          label: Text(isPassword == true ? 'password' : 'username'),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
