import 'package:farmdee/src/widgets/app_button.dart';
import 'package:farmdee/src/widgets/app_input.dart';
import 'package:farmdee/src/widgets/dialogs/app_bottom_dialog.dart';
import 'package:flutter/material.dart';

import '../model/name_password_model.dart';
class GetPasswordWifiDialog extends StatelessWidget {
  Function(String) onPasswordChang;
  String password = '';
   GetPasswordWifiDialog({Key? key, required this.onPasswordChang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AppBottomDialog( title: 'โปรดระบุรหัสผ่าน Wifi',
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2,
              padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 100),
              child: Center(
                child: AppInput(
                  onChanged: (val){
                    onPasswordChang(val);
                    // print('thisVal : ${val}');
                    // password = val;

                  },

                ),
              ),
            ),
            Positioned(
                top: 80,
                child: Container(
                  padding: EdgeInsets.only(left: 20,right: 20,bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                    onPressed: (){

                      // print('wifiModel.wifiPassword : ${password}');
                      // print('widget.wifiModel.wifiPassword : ${wifiModel.wifiPassword}');
                      // print('widget.wifiModel.name : ${wifiModel.wifiName}');
                      // wifiModel.wifiPassword = password;
                      Navigator.pop(context,true);
                      // if(widget.wifiModel.wifiPassword!=''){
                      //   Navigator.pop(context,widget.wifiModel);
                      // }

                    },
                    type: AppButtonType.primary,
                    text: 'ยืนยันรหัสผ่าน',
                  ),
                ))
          ],
        )
    );
  }
}

// class GetPasswordWiFiDialog extends StatefulWidget {
//   String password = '';
//   final WifiAndPassword wifiModel;
//    GetPasswordWiFiDialog({Key? key, required this.wifiModel}) : super(key: key);
//
//   @override
//   State<GetPasswordWiFiDialog> createState() => _GetPasswordWiFiDialogState();
// }
//
// class _GetPasswordWiFiDialogState extends State<GetPasswordWiFiDialog> {
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }
