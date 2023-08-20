import 'package:farmdee/src/module/verify_mobile/address_service.dart';
import 'package:farmdee/src/module/verify_mobile/model/verify_otp_model.dart';
import 'package:farmdee/src/utils/constants.dart';
import 'package:farmdee/src/widgets/text/detail_text.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import 'model/address_model.dart';

class GetOtpPage extends StatefulWidget {
  final String phoneNumber;
  String? otp;
  String errorMessage = '';
  bool hasError = false;
  final AddressModel model;
   GetOtpPage({Key? key, required this.phoneNumber, required this.model}) : super(key: key);

  @override
  State<GetOtpPage> createState() => _GetOtpPageState();
}

class _GetOtpPageState extends State<GetOtpPage> {
  AddressService service = AddressService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Column(
                children: [
                  Spacer(),
                  DetailText(text: 'รหัส OTP 6 หลัก ถูกส่งไปที่เบอร์',color: TEXT_COLOR,),
                  DetailText(text: '${widget.phoneNumber}',color: TEXT_COLOR),
                  SizedBox(height: 10,),
                  OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 50,
                    style: TextStyle(
                        fontSize: 17
                    ),
                    hasError: widget.hasError,

                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onCompleted: (pin) async {
                      widget.otp = pin;
                      VerifyOtpModel? result = await service.sendVerifyOtp(widget.otp!,widget.phoneNumber);
                      if(result != null){
                        print('status : ${result.status}');
                        if(result.status == 'approved'){
                          bool createdAddress = await service.createAddress(widget.model);
                          if(createdAddress){
                            Navigator.pop(context,true);

                          }
                        }else{
                          setState(() {
                            widget.hasError = true;
                            widget.errorMessage = 'OTP ไม่ถูกต้อง';
                          });
                        }

                      }else{
                        setState(() {
                          widget.hasError = true;
                          widget.errorMessage = 'OTP ไม่ถูกต้อง';
                        });
                      }
                    },
                    onChanged: (value){
                      widget.otp = value;
                      setState(() {
                        widget.hasError = false;
                        widget.errorMessage = '';
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  DetailText(text: widget.errorMessage,color: Colors.red,),
                  Spacer(),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
