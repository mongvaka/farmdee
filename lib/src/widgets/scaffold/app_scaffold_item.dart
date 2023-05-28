import 'package:farmdee/src/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants.dart';
import 'widgets/app_top_save_button.dart';

class AppScaffoldItem extends StatelessWidget {
  final Widget child;
  final String title;
  final String? submitText;
  final Function? onPressSubmit;
  final bool canBack;
  const AppScaffoldItem({Key? key, required this.child, required this.title, this.onPressSubmit, required this.canBack, this.submitText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: BACKGROUND_COLOR,
        navigationBar: CupertinoNavigationBar(

          padding: EdgeInsetsDirectional.zero,
          leading:canBack? GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                );
              },
              child:Container(
                padding: const EdgeInsets.only(left: 18,right: 10),
                width: 45,
                color: const Color.fromRGBO(245, 246, 248, 0.8),
                child: SvgPicture.asset(
                  'assets/icons/left.svg',
                ),
              )
          ):null,
          middle: Text(title,
            style: const TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
          ),
          border: Border.all(
            style: BorderStyle.none,
          ),
          backgroundColor: BACKGROUND_COLOR,
          trailing:onPressSubmit!=null?
          Container(
            padding: EdgeInsets.only(left: 18,right: 10),
            width: 100,
            color: const Color.fromRGBO(245, 246, 248, 0.8),
            child: AppTopSaveButton(text: submitText??'บันทึก',onPressed: (){
              onPressSubmit!();
            },),
          ):null,
        ),
        child: child
    );
  }
}
