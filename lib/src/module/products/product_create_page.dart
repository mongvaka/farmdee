import 'dart:io';

import 'package:farmdee/src/module/products/models/product_option.dart';
import 'package:farmdee/src/module/products/widgets/create_product_option_card.dart';
import 'package:farmdee/src/module/products/widgets/select_category_option.dart';
import 'package:farmdee/src/module/products/product_detail_service.dart';
import 'package:farmdee/src/module/shop/models/category_model.dart';
import 'package:farmdee/src/module/shop/shop_service.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:farmdee/src/widgets/text/detail_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_input.dart';
import 'models/create_product_option_model.dart';
import 'models/product_detail_model.dart';

class ProductCreatePage extends StatefulWidget {
  ProductDetailModel model = ProductDetailModel.empty();

  ProductCreatePage({Key? key}) : super(key: key);

  @override
  State<ProductCreatePage> createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  ProductDetailService service = ProductDetailService();
  ShopService shopService = ShopService();
  List<CategoryModel> category = [];
  List<XFile> images = [];
  List<CreateProductOptionModel> productOptionModels =[];

  @override
  void initState() {
    super.initState();
    _loadCategory();
  }
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem( title: 'สร้างสินค้า', canBack: true, tailing: const SizedBox(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppInput(
                placeholder: 'ชื่อสินค้า',
                onChanged: (val) {
                  setState(() {
                    widget.model.name = val;
                  });
                },
              ),
              SizedBox(height: 15,),
              AppInput(
                placeholder: 'รหัสสินค้า',
                onChanged: (val) {
                  setState(() {
                    widget.model.code = val;
                  });
                },
              ),
              SizedBox(height: 15,),
              AppInput(
                placeholder: 'รายละเอียด',
                onChanged: (val) {
                  setState(() {
                    widget.model.detail = val;
                  });
                },
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  DetailText(text: 'หมวดหมู่สินค้า'),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        showCategoryOption();
                      },
                   child: DetailText(text:getCategoryName(widget.model.categoryId,category)),)
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                    DetailText(text: 'ตัวเลือกสินค้า'),
                    Spacer(),
                  GestureDetector(
                      onTap: () {
                          setState(() {
                            widget.model.options.add(ProductOptionModel(name: 'ตัวเลือก${widget.model.options.length+2}', price: 0, id: 0));
                            print(widget.model.options.length);
                          });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 18, right: 10),
                        width: 45,
                        color: const Color.fromRGBO(245, 246, 248, 0.8),
                        child: SvgPicture.asset(
                          'assets/icons/plus.svg',
                        ),
                      ))
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 130,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...getProductOption(widget.model.options)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  DetailText(text: 'ภาพสินค้า'),
                  Spacer(),
                  GestureDetector(
                      onTap: () async{
                        var img = await ImagePicker().pickMultiImage();
                        setState(() {
                          images.addAll(img) ;
                        });
                        // img.forEach((element) {
                        //   print(element.name);
                        // });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 18, right: 10),
                        width: 45,
                        color: const Color.fromRGBO(245, 246, 248, 0.8),
                        child: SvgPicture.asset(
                          'assets/icons/plus.svg',
                        ),
                      ))
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                     ...getImageProduct(images)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  type: AppButtonType.primary,
                  text: 'สร้างสินค้า',
                  onPressed:() async {
                    SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context);
                    _dialog.show(message: 'กำลังสร้าง...', type: SimpleFontelicoProgressDialogType.threelines);
                    ProductDetailModel productModel = await service.createProduct(widget.model);
                    images.forEach((img) async{
                      await service.uploadImageProduct(img,productModel.id);
                    });
                    _dialog.hide();
                    // if(result){
                    //   Navigator.pop(context);
                    // }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCategoryOption() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return SelectCategoryOption(options: category,);
        }).whenComplete(() {

    }
    ).then((value){
      if(value!=null){
        setState(() {
          widget.model.categoryId = value;

        });
      }

    });
  }

  List<Widget> getImageProduct(List<XFile> images) {
    return images.map((e){
      return GestureDetector(
        onLongPress: (){
          setState(() {
            images.remove(e);
          });
        },
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius:const BorderRadius.all(Radius.circular(5))),
          child: Image.file(
            //to show image, you type like this.
            File(e.path),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      );
    }).toList();
  }

  List<Widget> getProductOption(List<ProductOptionModel> options) {
    return options.map((e) {
      return GestureDetector(
        onLongPress: (){
          print(e.id);
          setState(() {
            widget.model.options.remove(e);

          });
        },
        child: CreateProductOptionCard(model: e,onNameChange: (name){
          setState(() {
            e.name = name;

          });
        },
        onPriceChange: (price){
          setState(() {
            e.price = price;
          });
        },
        ),
      );
    }).toList();
  }

  void _loadCategory() {
    shopService.category().then((value) {
      setState(() {
        category = value;
      });

    });
  }

  getCategoryName(int categoryId, List<CategoryModel> category) {
    if(categoryId == 0){
      return 'ไม่ระบุ';
    }
    if(category.isEmpty){
      return '';
    }
   return category.firstWhere((element) => element.id == categoryId).name;
  }
}
