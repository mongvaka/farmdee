import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/style.dart';
import '../../../utils/constants.dart';
import '../models/message_model.dart';

class MessageCard extends StatefulWidget {
  final Function(MessageModel) onPress;
  final Function(MessageModel) onPressSwitch;
  final MessageModel model;
  const MessageCard({Key? key, required this.onPress, required this.onPressSwitch,  required this.model}) : super(key: key);

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {


    return  widget.model.answer!=null? rightMessage():leftMessage();
  }
  Widget leftMessage(){
    // print('widget.model.answer');
    // print(widget.model.answer);
    return  SizedBox(
      child: Row(
        children: [
          Spacer(),
          Container(
            constraints: BoxConstraints(maxWidth: 270),
              decoration: BoxDecoration(

                  color: Colors.blue.shade50,
                  borderRadius:
                  BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),bottomLeft:Radius.circular(20) )),
              margin: const EdgeInsets.symmetric(
                  vertical: 5, horizontal: 8),
              child: Padding(
                padding: EdgeInsets.all(6),
                  child:widget.model.type == 'Message'? AutoSizeText(
                    textAlign: TextAlign.left,
                    maxLines:5,
                    minFontSize: 10,
                    widget.model.message??'',
                    style: ClientStyle.chatStyle,
                  ):Image.network('${API_URL}/${widget.model.message}')
              )
          ),
        ],
      ),
    );
  }
  Widget rightMessage(){
    return  SizedBox(
      child: Row(
        children: [
          Container(
              constraints: BoxConstraints(maxWidth: 270),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) )),
              margin: const EdgeInsets.symmetric(
                  vertical: 5, horizontal: 8),
              child:  Padding(
                padding: EdgeInsets.all(6),
                child:widget.model.type == 'Message'? AutoSizeText(
                  textAlign: TextAlign.left,
                  maxLines:5,
                  minFontSize: 10,
                  widget.model.message??'',
                  style: ClientStyle.chatStyle,
                ):Image.network('${API_URL}/${widget.model.message}')
                ,
              )
          ),
          Spacer(),
        ],
      ),
    );
  }
}
