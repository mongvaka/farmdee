import 'dart:convert';

import 'package:farmdee/src/module/products/models/create_product_image.dart';
import 'package:farmdee/src/module/products/models/product_detail_model.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';

import '../../shared/basic_service.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

import '../../utils/constants.dart';

class ProductDetailService {
  final BasicService _baseService = BasicService();
  Future<ProductDetailModel?> getProductDetail(int id) async {
    String url = '/product/product-detail';
    Response? res = await _baseService.post({"id": id}, url);
    if (res?.body == null) {
      return null;
    }
    return ProductDetailModel.fromJson(jsonDecode(utf8.decode(res!.bodyBytes)));
  }

  Future<bool> addProductToOrder(
      int productId, int value, int optionId, bool activate) async {
    String url = '/product/add-product-to-bucket';
    final LocalStorage storage = LocalStorage('auth');
    await storage.ready;
    int? buyerId = storage.getItem('id');
    Response? res = await _baseService.post({
      "productId": productId,
      "buyerId": buyerId,
      "sellerId": null,
      "value": value,
      "optionId": optionId,
      "activate": activate
    }, url);
    if (res?.body == null) {
      return false;
    }
    return true;
  }

  createProduct(ProductDetailModel model) async {
    print('product : ${model.toJson()}');
    String url = '/product/create-product';
    Response? res = await _baseService.post(model.toJson(), url);
    return ProductDetailModel.fromJson(jsonDecode(res.body)); res.body;
  }
  createImagesProduct(CreateProductImageModel model) async {
    String url = '/product/create-image-product';
    Response? res = await _baseService.post(model.toJson(), url);
    if (res?.body == null) {
      return false;
    }
    return true;
  }
  uploadImageProduct(XFile imageFile,int productId) async {
    var stream =  http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    final LocalStorage storage = LocalStorage('auth');
    await storage.ready;
    String url = '$API_URL/product/upload-image';
    String? token =  storage.getItem('token');
    var uri = Uri.parse(url);
    Map<String,String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =  http.MultipartRequest("POST", uri);
    var multipartFile =  http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    request.headers.addAll(header);
    String? imageUrl;
    bool isDone = false;
    request.files.add(multipartFile);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) async{
      CreateProductImageModel imageModel = CreateProductImageModel(name: value.toString(), url:'uploads/product-images/' , type: 'JPEG', productId: productId);
      await createImagesProduct(imageModel);
      imageUrl = value.toString();
    }).onDone(() {
      isDone = true;
    });
    while(!isDone){
      await Future.delayed(const Duration(seconds: 1));
    }
    return imageUrl;
  }
}
