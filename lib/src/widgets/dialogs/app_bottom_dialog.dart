import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class AppBottomDialog extends StatelessWidget {
  final Widget child;
  final String title;
  const AppBottomDialog({Key? key, required this.child,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: 5,bottom: 13),
                    height: 6,width: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  TitleText(
                      text: title,
                      color: TEXT_COLOR,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ],),
              )
          ),


          Container(
            padding: EdgeInsets.only(top: 55),
              child: SingleChildScrollView(child: child))
        ],
      ),
    );
  }
}
