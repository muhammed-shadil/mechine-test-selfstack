import 'package:chat_server_mechine_test/constants.dart';
import 'package:chat_server_mechine_test/controller/bloc/chat/chat_bloc.dart';
import 'package:chat_server_mechine_test/dashchat.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeScreenwrapper extends StatelessWidget {
  const HomeScreenwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(socketChannel: connectToServer()),
      child: HomeScreen(),
    );
  }

  WebSocketChannel connectToServer() {
    final wsUrl = Uri.parse(
        'wss://echo.websocket.org/.ws'); // Replace with your server URL
    return WebSocketChannel.connect(wsUrl);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChatUser user = ChatUser(id: "1");
  List<ChatMessage> allMessages = [];
  final MyDashChat myDashChat = MyDashChat();

  @override
  void initState() {
    super.initState();
    final WebSocketChannel channel = BlocProvider.of<ChatBloc>(context)
        .socketChannel; // Access channel from ChatBloc

    channel.stream.listen((message) {
      // Handle incoming messages from server (e.g., echo replay)
      print("${message.toString()}podammmmmmmaa");

      BlocProvider.of<ChatBloc>(context).add(ReceiveMessage(message:message));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: constants.fillcolor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is SuccessSend) {
                allMessages = state.list;
              } else if (state is Receivemessage) {
                // Update allMessages list to include received messages
                allMessages.add(ChatMessage(
                  text: state
                      .message, // Extract message content from ReceiveMessage
                  user: ChatUser(id: 'server'),
                  createdAt: DateTime.now(), // Identify server messages
                ));
              } else if (state is senderror) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errormessage),
                  ),
                );
              }
              return DashChat(
                messageOptions: myDashChat.myMessageOptions(),
                messageListOptions: myDashChat.myMessageListOptions(),
                inputOptions: myDashChat.myInputOptions(),
                currentUser: user,
                onSend: (ChatMessage m) {
                  BlocProvider.of<ChatBloc>(context)
                      .add(sendmessage(message: m));
                  // BlocProvider.of<ChatBloc>(context)
                  //     .add(ReceiveMessage(message: m));
                },
                messages: allMessages,
              );
            },
          ),
        ),
      ),
    );
  }
}
