import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/foundation.dart'; // For @required
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WebSocketChannel socketChannel; // Injected from BlocProvider

  List<ChatMessage> allMessages = [];

  ChatBloc({required this.socketChannel}) : super(ChatInitial()) {
    on<sendmessage>(_sendmessage);
    on<ReceiveMessage>(_receivemessage); // Added handler for received messages
  }

  FutureOr<void> _sendmessage(
      sendmessage event, Emitter<ChatState> emit) async {
    try {
      // Attempt to send message through WebSocket
      socketChannel.sink
          .add(event.message.text); // Assuming the message has a text property
      print("${event.message.text}podaaa");
      allMessages.insert(
          0, event.message); // Update UI first for responsiveness
      emit(SuccessSend(list: allMessages));
    } catch (error) {
      emit(senderror(errormessage: error.toString())); // Handle errors
    }
  }

  FutureOr<void> _receivemessage(
      ReceiveMessage event, Emitter<ChatState> emit) {
        print("objectddddddddddddddddddddddddddddddd");
         print("${event.message}podaaawwwwwwwwwwwwwwww");

    ChatMessage m1 = ChatMessage(
      text: event.message, // Extract message content from event
      user: ChatUser(id: '2', firstName: "server"),
      createdAt: DateTime.now(), // Identify server messages
    );
    allMessages.insert(0, m1);
    print(m1);
    emit(SuccessSend(list: allMessages)); // Update UI with received message
  }
}
