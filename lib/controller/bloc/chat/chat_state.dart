// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
class SuccessSend extends ChatState {
  List<ChatMessage> list;
  SuccessSend({
    required this.list,
  });
 }
 class senderror extends ChatState{
  final String errormessage;

  senderror({required this.errormessage});


 }
 class Receivemessage extends ChatState{
  final String message;

  Receivemessage({required this.message});

 }
