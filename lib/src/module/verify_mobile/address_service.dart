import 'dart:convert';

import 'package:farmdee/src/module/verify_mobile/model/address_model.dart';
import 'package:farmdee/src/module/verify_mobile/model/verify_otp_model.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

import '../../shared/basic_respones.dart';
import '../../shared/basic_service.dart';
import 'model/address_option_model.dart';

class AddressService {
  final BasicService _baseService  =  BasicService();
  Future<BasicResponse<AddressOptionModel>> countryList() async {
    String url = '/address/country';
    Response? res = await _baseService.post({}, url);
    if (res?.body == null) {
      return BasicResponse();
    }
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), AddressOptionModel.fromJson);
  }
  Future<BasicResponse<AddressOptionModel>> provinceList(String countryCode) async {
    String url = '/address/province';
    Response? res = await _baseService.post({"countryCode":countryCode}, url);
    if (res?.body == null) {
      return BasicResponse();
    }
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), AddressOptionModel.fromJson);
  }
  Future<BasicResponse<AddressOptionModel>> districtList(String provinceCode) async {
    String url = '/address/district';
    Response? res = await _baseService.post({"provinceCode":provinceCode}, url);
    if (res?.body == null) {
      return BasicResponse();
    }
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), AddressOptionModel.fromJson);
  }
  Future<BasicResponse<AddressOptionModel>> subDistrictList(String districtCode) async {
    String url = '/address/sub-district';
    Response? res = await _baseService.post({"districtCode":districtCode}, url);
    if (res?.body == null) {
      return BasicResponse();
    }
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), AddressOptionModel.fromJson);
  }
  // Future<bool> confirmMobileNumber(String mobileNumber) async {
  //   String url = '/address/confirmMobile';
  //   Response? res = await _baseService.post({"mobileNumber":mobileNumber}, url);
  //   return res?.body != null;
  // }
  Future<bool> confirmOtp(String mobileNumber) async {
    String url = '/address/confirm-otp';
    Response? res = await _baseService.post({"mobileNumber":mobileNumber}, url);
    return res?.body != null;
  }
  Future<bool> createAddress(AddressModel model) async {
    final LocalStorage storage = LocalStorage('auth');
    await storage.ready;
    int userId =  storage.getItem('id');
    model.userId = userId;
    String url = '/users/create-address';
    Response? res = await _baseService.post(model.toJson(), url);
    return res?.body != null;
  }
  Future<VerifyOtpModel?> sendVerifyCode(String phoneNumber) async {
    String url = '/address/verify-phone-number';
    Response? res = await _baseService.post({"phoneNumber":phoneNumber}, url);
    if(res==null){
      return null;
    }
    return VerifyOtpModel.fromJson(jsonDecode(res!.body));
  }
  Future<VerifyOtpModel?> sendVerifyOtp(String otp,String phoneNumber) async {
    String url = '/address/verify-otp';
    Response? res = await _baseService.post({"phoneNumber":phoneNumber,"otpCode":otp}, url);
    if(res==null){
      return null;
    }
    return VerifyOtpModel.fromJson(jsonDecode(res!.body));
  }
}