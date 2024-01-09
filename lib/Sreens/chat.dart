import 'package:chatapp/models.dart';
import 'package:chatapp/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.receiver}) : super(key: key);
  final int receiver;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);

      chatProvider.getTotalChat(widget.receiver);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ChatProvider>(
        builder: (context, value, child) {
          if (value.isLoading == true) {
            return const CircularProgressIndicator();
          } else {
            return Text(value.chatTotal.toString());
          }
        },
      ),
    );
  }
}
