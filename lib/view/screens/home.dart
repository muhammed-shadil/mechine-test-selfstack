import 'package:chat_server_mechine_test/utils/constants.dart';
import 'package:chat_server_mechine_test/controller/bloc/chat/chat_bloc.dart';
import 'package:chat_server_mechine_test/view/widgets/dashchat.dart';
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
        'wss://echo.websocket.org/.ws'); 
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
    final WebSocketChannel channel =
        BlocProvider.of<ChatBloc>(context).socketChannel;

    channel.stream.listen((message) {
      BlocProvider.of<ChatBloc>(context).add(ReceiveMessage(message: message));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Server bot",
              style: TextStyle(fontSize: 25),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.5,
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
                    allMessages = state.list;
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
                    },
                    messages: allMessages,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
