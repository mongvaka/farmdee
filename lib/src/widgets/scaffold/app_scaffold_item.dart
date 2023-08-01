import 'package:auto_size_text/auto_size_text.dart';
import 'package:farmdee/src/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants.dart';
import 'widgets/app_top_save_button.dart';

class AppScaffoldItem extends StatelessWidget {
  final Widget child;
  final String title;
  final bool canBack;
  final Widget tailing;
  const AppScaffoldItem(
      {Key? key,
      required this.child,
      required this.title,
      required this.canBack,
      required this.tailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: BACKGROUND_COLOR,
        navigationBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.zero,
          leading: canBack
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 18, right: 10),
                    width: 45,
                    color: const Color.fromRGBO(245, 246, 248, 0.8),
                    child: SvgPicture.asset(
                      'assets/icons/left.svg',
                    ),
                  ))
              : null,
          middle: AutoSizeText(
            title,
            minFontSize: 10,
            maxLines: 1,
            style: const TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
          ),
          border: Border.all(
            style: BorderStyle.none,
          ),
          backgroundColor: BACKGROUND_COLOR,
          trailing: tailing
          // onPressSubmit != null
          //     ? Container(
          //         padding: EdgeInsets.only(left: 18, right: 10),
          //         width: 100,
          //         color: const Color.fromRGBO(245, 246, 248, 0.8),
          //         child: AppTopSaveButton(
          //           text: submitText ?? 'บันทึก',
          //           onPressed: () {
          //             onPressSubmit!();
          //           },
          //         ),
          //       )
          //     : null,
        ),
        child: SafeArea(
            child: child));
  }
}
