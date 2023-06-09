import '../module/message/models/message_model.dart';

enum SocketStatus { none,newChatMessage, newNotification }

class SocketState {
  SocketStatus status;
  final MessageModel? chatMessage;
   SocketState._({
    this.status = SocketStatus.none,
    this.chatMessage,
  });
   SocketState.nothing() : this._(status: SocketStatus.none);

   SocketState.newMessage(MessageModel message) : this._(status: SocketStatus.newChatMessage,chatMessage: message);
   SocketState.newNotification() : this._(status: SocketStatus.newChatMessage);



}