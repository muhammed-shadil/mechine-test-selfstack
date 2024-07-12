part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}
class sendmessage extends ChatEvent{
  final ChatMessage message;

  sendmessage({required this.message});
}
class ReceiveMessage extends ChatEvent{
  final String message;

  ReceiveMessage({required this.message});
}