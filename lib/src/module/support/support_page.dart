import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(child: Center(child: LabelText(text: 'เร็วๆนี้',),), title: 'ฝ่ายบริการลูกค้า', canBack: false);
  }
}
