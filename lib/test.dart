import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class TestChat extends StatefulWidget {
  const TestChat({Key? key}) : super(key: key);

  @override
  State<TestChat> createState() => _TestChatState();
}

class _TestChatState extends State<TestChat> {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8000/ws/chat/'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              return Text(snapshot.data.toString());
            }),
      ),
    );
  }
}
