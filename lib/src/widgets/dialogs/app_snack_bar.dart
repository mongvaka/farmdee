import 'package:farmdee/src/widgets/text/detail_text.dart';
import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/material.dart';

class AppSnackBar extends StatelessWidget {
  final String text;
  const AppSnackBar({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      width: size.width,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.red.shade100,
          border: Border.all(
            color:Colors.white,
          ),
          borderRadius:
          BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DetailText(text: text,color: Colors.red,)
        ],
      ),
    );
  }
}
