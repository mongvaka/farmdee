import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/module/message/models/message_search.dart';
import 'package:farmdee/src/module/message/models/message_model.dart';
import 'package:farmdee/src/module/message/models/send_message_model.dart';
import 'package:farmdee/src/module/message/widegets/message_card.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/app_input.dart';
import 'message_service.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  int currentSegment = 0;
  MessageSearch search = MessageSearch();
  MessageService service = MessageService();
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List<MessageModel> _posts = [];
  void _loadMore() async {
    if (search.page.last == false &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      search.page.offset += 1;

      try {
        final res = await service.getChatMessages(search);
        search.fromResponse(res);
        final fetchedPosts = res.content;
        if (fetchedPosts!.isNotEmpty) {
          setState(() {
            print(fetchedPosts);

            _posts!.addAll(fetchedPosts);
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res = await service.getChatMessages(search);
      print(res);
      search.fromResponse(res);
      setState(() {
        if(res.content !=null){
          _posts = res!.content!;
        }
      });
    } catch (err,t) {
      if (kDebugMode) {
        print(t);
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }
  String message = "";
  String messageType = "Message";
  TextEditingController typeMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(title: 'ติดต่อสอบถาม', canBack: false,
      child: Column(
        children: [
          Expanded(
            child: _posts!.isNotEmpty
                ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _posts?.length,
                controller: _controller,
                itemBuilder: (_, index) {
                  MessageModel model = _posts![index];
                  return MessageCard(
                      onPress: (MessageModel model) {

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           SwitchPage(homeModel: model)),
                        // ).then((value){
                        //   _firstLoad();
                        //   _controller = ScrollController()..addListener(_loadMore);
                        // });
                        // final router = context.router;
                        // router.push(ClientDetailRoute(clientId: clientId));
                      },
                      onPressSwitch: (MessageModel model) {
                        // service.switchStatus(model);
                      },
                      model:model

                  );
                })
                :!_posts.isEmpty? const Center(child: CupertinoActivityIndicator()):Center(child: LabelText(text: 'ไม่มีข้อมูล',),),
          ),
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 1, bottom: 1),
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              child:
                Row(

                  children: [
                    SizedBox(width: 5,),
                    Flexible(
                      flex: 15,
                      child: Container(
                        child: AppInput(
                          controller: typeMessageController,
                          placeholder: 'พิมพ์ข้อความ',
                          onChanged: (val) {
                            setState(() {
                              message = val;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () async {
                          SendMessageModel model = SendMessageModel(message: message, type: messageType, answerId: null, clientId: null, supportId: null);
                          await service.sendMessage(model);
                          setState(() {
                            _posts.add(MessageModel(message: message, type: 'Message', answer: null));
                            message = "";
                            typeMessageController.text = '';
                          });
                        },
                        child: Container(
                          child: SvgPicture.asset(
                            'assets/icons/send.svg',
                            height: 28,
                            width:28,

                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}
