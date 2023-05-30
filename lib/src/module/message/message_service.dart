import 'dart:convert';

import 'package:http/http.dart';

import '../../shared/basic_respones.dart';
import '../../shared/basic_service.dart';
import 'models/message_search.dart';
import 'models/message_model.dart';
import 'models/send_message_model.dart';

class MessageService {
   BasicService _baseService  =  BasicService();
  Future<BasicResponse<MessageModel>> getChatMessages(MessageSearch search) async {
    String url = '/support/search-chat-message';
    Response? res = await _baseService.post(search.toJson(), url);
    print('res');
    print(res!.body);
    if (res?.body == null) {
      return BasicResponse();
    }
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), MessageModel.fromJson);
  }
  Future<bool> sendMessage(SendMessageModel model) async {
    String url = '/support/send-message';

    Response? res = await _baseService.post(model.toJson(), url);
    if (res?.body == null) {
      return false;
    }
    return true;
  }
}