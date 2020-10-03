import 'dart:async';

import 'package:dash_chat/dash_chat.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatBot',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final ChatUser user = ChatUser(
    name: "Usuário",
    firstName: "Usuário",
    lastName: "Fulano",
    uid: "0001",
  );

  final ChatUser bot = ChatUser(
      name: "Bot",
      uid: "0002",
      avatar: "https://img.icons8.com/plasticine/344/bot.png");

  List<ChatMessage> messages = List<ChatMessage>();

  Dio _dio;

  @override
  void initState() {
    super.initState();
    initDio();
    sendMessage("/start");
  }

  void onSend(ChatMessage message) async {
    print(message.toJson());
    setState(() {
      messages = [...messages, message];
      print(messages.length);
    });
    sendMessage(message.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat App"),
        ),
        body: DashChat(
          inverted: false,
          onSend: onSend,
          sendOnEnter: true,
          textInputAction: TextInputAction.send,
          user: user,
          inputDecoration:
              InputDecoration.collapsed(hintText: "Digite a mensagem aqui..."),
          dateFormat: DateFormat('dd-MMM-yyyy'),
          timeFormat: DateFormat('HH:mm'),
          messages: messages,
          showUserAvatar: false,
          showAvatarForEveryMessage: false,
          scrollToBottom: true,
          inputMaxLines: 5,
          messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
          alwaysShowSend: true,
          inputTextStyle: TextStyle(fontSize: 16.0),
          inputContainerStyle: BoxDecoration(
            border: Border.all(width: 0.0),
            color: Colors.white,
          ),
        ));
  }

  void initDio() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://seusite.com/seu_backend",
      connectTimeout: 10000,
    );
    _dio = new Dio(options);
  }

  Future<void> sendMessage(String msg) async {
    Response response = await _dio.get("?msg=${Uri.encodeFull(msg)}");
    print(response.data.toString());
    setState(() {
      messages = [
        ...messages,
        ChatMessage(text: response.data.toString(), user: bot)
      ];
    });
  }
}
