import 'package:chatapp/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      final userProvide = Provider.of<UserProvider>(context, listen: false);
      userProvide.getTotalUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<UserProvider>(
      builder: (context, value, child) {
        if (value.isLoading == true) {
          return const CircularProgressIndicator();
        } else {
          return ListView.builder(
              itemCount: value.users.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 100,
                  child: Card(
                    child: Center(
                      child: Text(
                        value.users[index].username,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              });
        }
      },
    ));
  }
}
