import 'package:farmdee/src/widgets/app_input.dart';
import 'package:farmdee/src/widgets/app_input_money.dart';
import 'package:flutter/material.dart';

import '../models/product_option.dart';

class CreateProductOptionCard extends StatefulWidget {
  final  ProductOptionModel model;
  final Function(String) onNameChange;
  final Function(double) onPriceChange;
   TextEditingController? controllerName;
   TextEditingController? controllerPrice;
   CreateProductOptionCard({Key? key, required this.model, required this.onNameChange, required this.onPriceChange}) : super(key: key){
     controllerName = TextEditingController(text: model.name);
     controllerPrice = TextEditingController(text: '${model.price}');
   }

  @override
  State<CreateProductOptionCard> createState() => _CreateProductOptionCardState();
}

class _CreateProductOptionCardState extends State<CreateProductOptionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      height: 200,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          
          color: Colors.white,
          border: Border.all(
            color:Colors.white,
          ),

          borderRadius:
          BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          AppInput(
          placeholder: 'ชื่อตัวเลือก',

          onChanged: (val){
            widget.onNameChange(val);

          },
          ),
          SizedBox(height: 5,),
          AppInputMoney(
            placeholder: 'ราคา',
            onChanged: (val){
          widget.onPriceChange(val);
            },
          )
        ],
      ),
    );
  }
}
