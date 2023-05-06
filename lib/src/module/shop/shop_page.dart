import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(child: Center(child: LabelText(text: 'เร็วๆ นี้',),), title: 'สั่งซื้อสินค้า', canBack: false);
  }
}
