import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:farmdee/src/module/verify_mobile/address_service.dart';
import 'package:farmdee/src/module/verify_mobile/get_otp_page.dart';
import 'package:farmdee/src/module/verify_mobile/model/address_model.dart';
import 'package:farmdee/src/module/verify_mobile/model/address_option_model.dart';
import 'package:farmdee/src/shared/basic_respones.dart';
import 'package:farmdee/src/widgets/app_button.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../widgets/app_input.dart';
import '../login/widgets/label_text.dart';
import 'model/verify_otp_model.dart';
import 'widgets/select_address_dialog.dart';
enum AddressType{
  country ,
  province,
  district,
  subDistrict
}
class VerifyMobile extends StatefulWidget {
  AddressModel model = AddressModel(
      userId: 0, 
      countryCode: '', 
      provinceCode: '', 
      districtCode: '', 
      subDistrictCode: '', 
      phoneNumber: '',
    address: ''
  );
  AddressOptionModel? country = AddressOptionModel(name: "ประเทศไทย", code: '66');
  AddressOptionModel? province;
  AddressOptionModel? district;
  AddressOptionModel? subDistrict;

  BasicResponse<AddressOptionModel>? countryOptions;
  BasicResponse<AddressOptionModel>? provinceOptions;
  BasicResponse<AddressOptionModel>? districtOptions;
  BasicResponse<AddressOptionModel>? subDistrictOptions;
   VerifyMobile({Key? key}) : super(key: key);

  @override
  State<VerifyMobile> createState() => _VerifyMobileState();
}

class _VerifyMobileState extends State<VerifyMobile> {
  AddressService service = AddressService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.country = AddressOptionModel(name: "ประเทศไทย", code: '66');
    widget.model.countryCode = widget.country!.code;
    service.countryList().then((value){
      widget.countryOptions = value;
    });
    service.provinceList(widget.country!.code).then((value){
      widget.provinceOptions = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(
      tailing: SizedBox(),
      canBack: true,
      title: 'ที่อยู่ในการจัดส่ง',
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15,right: 15,top: 15),
              child: Column(
                children: [

                  // Row(
                  //   children: [
                  //     Spacer(),
                  //     TitleText(text: 'ที่อยู่ในการจัดส่ง',),
                  //     Spacer(),
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      showModal(context, 'เลือกประเทศ', widget.countryOptions!, AddressType.country);
                    },
                    child: Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          TitleText(text: 'ประเทศ'),
                          Spacer(),
                          TitleText(text: '${widget.country!.name}')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      showModal(context, 'เลือกจังหวัด', widget.provinceOptions!, AddressType.province);
                    },
                    child: Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          TitleText(text: 'จังหวัด'),
                          Spacer(),
                          TitleText(text: '${widget.province?.name??'โปรดเลือกจังหวัด'}')

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      showModal(context, 'เลือกอำเภอ', widget.districtOptions!, AddressType.district);
                    },
                    child: Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),

                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          TitleText(text: 'อำเภอ'),
                          Spacer(),
                          TitleText(text: '${widget.district?.name??'โปรดเลือกอำเภอ'}')

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      showModal(context, 'เลือกตำบล', widget.subDistrictOptions!, AddressType.subDistrict);
                    },
                    child: Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),

                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          TitleText(text: 'ตำบล'),
                          Spacer(),
                          TitleText(text: '${widget.subDistrict?.name??'โปรดเลือกตำบล'}')

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  AppInput(
                    placeholder: 'ที่อยู่',
                    onChanged: (val) {
                      setState(() {
                        widget.model.address = val;
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 70,
                    color: Colors.white,
                    child: Material(
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          labelText: 'เบอร์มือถือ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'TH',
                        onChanged: (phone) {
                          widget.model.phoneNumber = '${phone.countryCode}${phone.number}';
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(text: 'ยืนยันที่อยู่จัดส่ง',type: AppButtonType.primary,onPressed: () async{

                    if(widget.country==null){
                      showErrorDialog('ประเทศ');
                      return;
                    }
                    if(widget.province==null){
                      showErrorDialog('จังหวัด');
                      return;
                    }
                    if(widget.district==null){
                      showErrorDialog('อำเภอ');
                      return;
                    }
                    if(widget.subDistrict==null){
                      showErrorDialog('ตำบล');
                      return;
                    }
                    // Navigator.pop(context,true);
                    VerifyOtpModel? result =  await service.sendVerifyCode(widget.model.phoneNumber);
                    if(result!=null){
                      print('widget.model.phoneNumber : ${widget.model.phoneNumber}');
                      bool result2 = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GetOtpPage(phoneNumber: widget.model.phoneNumber,model:widget.model)),
                      );
                      if(result2){
                        Navigator.pop(context,true);


                      }
                    }
                  },),
                ))
          ],
        ),
      ),
    );
  }
  void showModal(context,title,BasicResponse<AddressOptionModel> options,AddressType type) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return SelectAddressDialog(title: title,respons: options,);
        }).whenComplete(() {

    }
    ).then((value){
      if(value==null){
        return;
      }
      if(type == AddressType.country){

        setState(() {
          widget.country = value;
        });
        widget.model.countryCode =widget.country!.code;
            service.provinceList(widget.country!.code).then((value) {
            widget.provinceOptions = value;
        });
      }
      if(type == AddressType.province){
        setState(() {
          widget.province = value;

        });
        widget.model.provinceCode =widget.province!.code;
        service.districtList(widget.province!.code).then((value) {
          widget.districtOptions = value;
        });
      }
      if(type == AddressType.district){
        setState(() {
          widget.district = value;

        });
        widget.model.districtCode =widget.district!.code;

        service.subDistrictList(widget.district!.code).then((value) {
          widget.subDistrictOptions = value;
        });
      }
      if(type == AddressType.subDistrict){
        setState(() {
          widget.subDistrict = value;

        });
        widget.model.subDistrictCode =widget.subDistrict!.code;

      }
    });
  }

  void showErrorDialog(String s) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'โปรดระบุข้อมูล${s}',
        titleFontSize: 16,
        messageFontSize: 14,
        message:
        'ข้อมูล${s}ไม่สามารถเว้นว่างได้',
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
