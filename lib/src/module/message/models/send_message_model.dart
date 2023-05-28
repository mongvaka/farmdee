

import 'package:localstorage/localstorage.dart';

class SendMessageModel  {
  String message;
  String type;
  int? answerId;
  int? clientId;
  int? supportId;

  SendMessageModel({
    required this.message,
    required this.type,
    required this.answerId,
     this.clientId,
    required this.supportId,
  });

  Map<String, dynamic> toJson() {
    final LocalStorage storage = LocalStorage('auth');
    int? ownerId =  storage.getItem('id');
    clientId = ownerId!;
    return
      {
        'message': message,
        'type': type,
        'answerId': answerId,
        'clientId': clientId,
        'supportId': supportId,
      };
  }
}
