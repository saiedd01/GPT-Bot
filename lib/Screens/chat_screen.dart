import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:gpt_final/Widget/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  static const apiKey = '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';
  Future<HttpClientResponse> sendRequest(String prompt) async {
    final client = HttpClient();
    final request = await client
        .postUrl(Uri.parse('https://api.openai.com/v1/completions'));
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('Authorization', 'Bearer $apiKey');
    request.add(utf8.encode(json.encode({
      'model': 'text-davinci-003',
      'prompt': prompt,
      'max_tokens': 2048,
      'stop': '',
      'temperature': 0.7,
    })));
    final response = await request.close();
    return response;
  }

  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  void sendMessage(message) async {
    final response = await sendRequest(message);
    if (response.statusCode == 200) {
      final completions =
      json.decode(await response.transform(utf8.decoder).join())['choices'];
      for (var completion in completions) {
        print(completion['text']);
        _messages.insert(0, ChatMessage(text: completion['text'], sender: "OpenAI"));
      }
      setState(() {});
    } else {
      print("Error Here!");
    }
  }

  void sendUser(String Text) {
    print(Text + "Controller");
    ChatMessage message = ChatMessage(
      text: Text,
      sender: 'You',
    );

    setState(() {
      _messages.insert(0, message);
    });
    _controller.clear();
    sendMessage(Text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}