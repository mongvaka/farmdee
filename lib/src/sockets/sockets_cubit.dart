import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:farmdee/src/sockets/sockets_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../module/message/models/answer_model.dart';
import '../module/message/models/message_model.dart';
import '../utils/constants.dart';


class SocketCubit extends Cubit<SocketState> {
  IO.Socket? socket;
  final int ownerId;
  SocketCubit({ required this.ownerId})
      : super(SocketState.nothing()) {
    print('socket colled');
    socket = IO.io(API_URL_PURE, <String, dynamic>{
      "transports": ["websocket"],});
    socket!.onConnect((_) {
      print('connect');
    });
    // final LocalStorage storage = LocalStorage('auth');
    // await storage.ready;
    // int? ownerId =  storage.getItem('id');
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
  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    print('stackTraceError');
    super.onError(error, stackTrace);
  }
}