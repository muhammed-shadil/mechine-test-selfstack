import 'dart:async';
import 'dart:math';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:chat_server_mechine_test/model/messagemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      // print("${event.message.text}podaaa");
      allMessages.insert(0, event.message);
      await addMessage(event.message);
      // Update UI first for responsiveness
      emit(SuccessSend(list: allMessages));
    } catch (error) {
      emit(senderror(errormessage: error.toString())); // Handle errors
    }
  }

  FutureOr<void> _receivemessage(
      ReceiveMessage event, Emitter<ChatState> emit)async {
    // print("objectddddddddddddddddddddddddddddddd");
    // print("${event.message}podaaawwwwwwwwwwwwwwww");

    ChatMessage m1 = ChatMessage(
      text: event.message, // Extract message content from event
      user: ChatUser(id: '2', firstName: "server"),
      createdAt: DateTime.now(), // Identify server messages
    );
    // print("$allMessages ttttttttttttttt");
    allMessages.insert(0, m1);

    // Update UI with received message
    await addMessage(m1);
 List<ChatMessage>pp= await getChatMessages();
 developer.log('the list is ${pp}');
 allMessages.addAll(pp);

    emit(Receivemessage(list: allMessages));

  }
}

Future<void> addMessage(ChatMessage m1) async {
  final user = FirebaseAuth.instance.currentUser;
  print(user);
  // Messagemodel chatMessage = Messagemodel(
  //     senderId: m1.user.id, message: m1.text, timestamp: m1.createdAt);
  await FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection("chat")
      .doc(m1.createdAt.toString())
      .set(m1.toJson());
}

Future<List<ChatMessage>> getChatMessages() async {
 try{
   final user = FirebaseAuth.instance.currentUser;

  final collection = FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .collection("chat");
  final snapshot = await collection
      .orderBy('createdAt', descending: true)
      .get(); // Order by creation time (descending)
// developer.log('the snapshot data is ${snapshot.docs}');
final data=snapshot.docs.map((doc)=>ChatMessage.fromJson(doc.data())).toList();
developer.log('the snapshot data is ${data[0].status}');
return data;
 }catch(e){
developer.log('the error is ${e.toString()}');
 }
return [];
   // Convert documents to ChatMessage objects
}
