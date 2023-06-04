import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:farmdee/src/sockets/sockets_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../module/message/models/answer_model.dart';
import '../module/message/models/message_model.dart';


class SocketCubit extends Cubit<SocketState> {
  IO.Socket? socket;
  SocketCubit()
      : super(const SocketState.nothing()){
    socket = IO.io("http://192.168.1.45:3033", <String, dynamic>{
      "transports": ["websocket"],});
    socket!.onConnect((_) {
      print('connect');
    });
    final LocalStorage storage = LocalStorage('auth');
    int? ownerId =  storage.getItem('id');
    socket!.on('message$ownerId', (data) {
      // print("data['answer']");
      // print(data['answer']);
      MessageModel newMessage = MessageModel(message: data['message'],
          type: data['type'],
          answer:data['answer']==null?null: UserModel(
              id: data['answer']['id']??1,
              email: data['answer']['email']??'',
              firstName: data['answer']['firstName']??'',
              lastName: data['answer']['lastName']??''
          )
      );
      emit(SocketState.newMessage(newMessage));
      // setState(() {
      //   _posts.insert(0,newMessage);
      //   // _controller = ScrollController()..addListener(_loadMore);
      //
      //   // _controller.animateTo(_controller.position.maxScrollExtent , duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      // });
      // _controller.animateTo(0.0 , duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

      // _controller.jumpTo(0.0);

      print(data);
    });
    socket!.connect();
  }
}