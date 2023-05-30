import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/module/products/models/product_detail_model.dart';
import 'package:farmdee/src/module/products/product_detail_service.dart';
import 'package:farmdee/src/module/shop/shop_search.dart';
import 'package:farmdee/src/module/shop/shop_service.dart';
import 'package:farmdee/src/module/shop/widgets/shop_card.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class ProductDetailPage extends StatefulWidget {
  final int id;
  const ProductDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentSegment = 0;
  ProductDetailService service = ProductDetailService();
  bool _isFirstLoadRunning = true;
  ProductDetailModel? model;


  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res = await service.getProductDetail(widget.id);
      setState(() {
        if(res!=null){
          model = res;
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

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(
      title: 'ข้อมูลสินค้า', canBack: false,
      child: Column(
        children: [
         Center(child: Text(model?.name??''))
        ],
      ),
    );
  }
}
