import '../module/message/models/message_model.dart';

enum SocketStatus { none,newChatMessage, newNotification }

class SocketState {
  final SocketStatus status;
  final MessageModel? chatMessage;
  const SocketState._({
    this.status = SocketStatus.none,
    this.chatMessage,
  });
  const SocketState.nothing() : this._(status: SocketStatus.none);

  const SocketState.newMessage(MessageModel message) : this._(status: SocketStatus.newChatMessage,chatMessage: message);
  const SocketState.newNotification() : this._(status: SocketStatus.newChatMessage);



}