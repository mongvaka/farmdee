import 'package:farmdee/src/widgets/dialogs/app_bottom_dialog.dart';
import 'package:farmdee/src/widgets/text/detail_text.dart';
import 'package:flutter/material.dart';

import '../../shop/models/category_model.dart';

class SelectCategoryOption extends StatelessWidget {
  final List<CategoryModel> options;
  const SelectCategoryOption({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBottomDialog(title: 'เลือกหมวดหมู่สินค้า' ,child:
      Column(
        children: [
          ...options.map((e) {
            return GestureDetector(
              onTap: (){
                Navigator.pop(context,e.id);
              },
              child: Container(
                width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius:const BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DetailText(text: e.name,),
                    ],
                  )),
            );
          }).toList()
        ],
      )
      , );
  }
}
