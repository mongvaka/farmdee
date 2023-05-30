

import 'answer_model.dart';

class MessageModel  {
  String? message;
  String? type;
  UserModel? answer;

  MessageModel({
    required this.message,
    required this.type,
    required this.answer,
  });

  factory MessageModel.fromJson(dynamic json) {
    print("json['answer']");
    print(json['answer']);
    return MessageModel(
      message: json['message'] ,
      type: json['type'],
      answer: json['answer'] ==null? null: UserModel.fromJson(json['answer']),
    );
  }
  @override
  Map<String, dynamic> toJson() {

    return
      {
        'message': message,
        'type': type,
        'answer': answer?.toJson(),
      };
  }
}
