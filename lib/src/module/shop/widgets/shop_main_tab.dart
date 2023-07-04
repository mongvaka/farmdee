import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widgets/scaffold/app_scaffold_item.dart';
import '../../bucket/bucket_page.dart';
import '../shop_service.dart';

class ShopMainPage extends StatefulWidget {
  const ShopMainPage({Key? key}) : super(key: key);

  @override
  State<ShopMainPage> createState() => _ShopMainPageState();
}

class _ShopMainPageState extends State<ShopMainPage> {
  ShopService service = ShopService();
  int? countBucket = 0;
  @override
  void initState() {
    super.initState();
    _getCountBucket();
  }
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(
      tailing: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BucketPage()),
          );
        },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(left: 5, right: 5),
            width: 45,
            color: const Color.fromRGBO(245, 246, 248, 0.8),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child:countBucket==0? SizedBox() : new Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: new Text(
                      '$countBucket',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/shopping_cart.svg',
                ),
              ],
            ),
          )
      ),
      title: 'สั่งอุปกรณ์',
      canBack: false,
      child: SizedBox(),
    );
  }
  void _getCountBucket(){
    service.countBucket().then((value) {
      setState(() {
        countBucket = value;
      });
    });
  }
}
