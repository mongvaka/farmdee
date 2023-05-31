import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/basic_respones.dart';
import '../../shared/basic_service.dart';
import '../../utils/constants.dart';
import 'models/message_search.dart';
import 'models/message_model.dart';
import 'models/send_message_model.dart';
import 'package:http/http.dart' as http;

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
   upload(XFile imageFile) async {
     var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
     var length = await imageFile.length();
     final LocalStorage storage = new LocalStorage('auth');
     String url = '$API_URL/support/upload-image';
     String? token =  storage.getItem('token');
     var uri = Uri.parse(url);
     Map<String,String> header = {
       'Content-Type': 'application/json',
       'Accept': 'application/json',
       'Authorization': 'Bearer $token'
     };
     var request = new http.MultipartRequest("POST", uri);
     var multipartFile = new http.MultipartFile('file', stream, length,
         filename: basename(imageFile.path));
     request.headers.addAll(header);
     //contentType: new MediaType('image', 'png'));

     request.files.add(multipartFile);
     var response = await request.send();
     print(response.statusCode);
     response.stream.transform(utf8.decoder).listen((value) {
       print(value);
     });
   }
}