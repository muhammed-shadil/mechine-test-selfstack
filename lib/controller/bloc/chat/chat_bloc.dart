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
  final WebSocketChannel socketChannel; 

  List<ChatMessage> allMessages = [];

  ChatBloc({required this.socketChannel}) : super(ChatInitial()) {
    on<sendmessage>(_sendmessage);
    on<ReceiveMessage>(_receivemessage);
  }

  FutureOr<void> _sendmessage(
      sendmessage event, Emitter<ChatState> emit) async {
    try {
      socketChannel.sink
          .add(event.message.text); 
      allMessages.insert(0, event.message);
      await addMessage(event.message);
      emit(SuccessSend(list: allMessages));
    } catch (error) {
      emit(senderror(errormessage: error.toString())); 
    }
  }

  FutureOr<void> _receivemessage(
      ReceiveMessage event, Emitter<ChatState> emit)async {

    ChatMessage m1 = ChatMessage(
      text: event.message,
      user: ChatUser(id: '2', firstName: "server"),
      createdAt: DateTime.now(), 
    );

    allMessages.insert(0, m1);

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
      .get();
final data=snapshot.docs.map((doc)=>ChatMessage.fromJson(doc.data())).toList();
developer.log('the snapshot data is ${data[0].status}');
return data;
 }catch(e){
developer.log('the error is ${e.toString()}');
 }
return [];
   
}
