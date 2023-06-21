import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:farmdee/src/module/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_input.dart';
import '../../widgets/app_input_email.dart';
import '../main/main_page.dart';
import 'auth_respones_model.dart';
import 'login_model.dart';
import 'register_model.dart';
import 'register_service.dart';
import 'widgets/label_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerUserName =
  TextEditingController(text: '');
  final TextEditingController _controllerMobile =
  TextEditingController(text: '');
  final RegisterModel _registerModel = RegisterModel.fromJson({'email': '', 'password': '', 'rePassword': '','fName':'','lName':''});
  String _errorPwd = '';
  String _errorMobile= '';
  String _errorUsername = '';
  RegisterService service = RegisterService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   width: 220,
                    //   child: Image.asset(
                    //     'assets/images/2xhuatai_logo-wh.png',
                    //     fit: BoxFit.contain,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Image.asset(
                          'assets/icons/logo.png',
                          width: 100,
                          height: 100,
                        ),
                        Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LabelText(
                              text: 'อีเมล',
                            ),
                            AppInputEmail(
                              controller: _controllerUserName,
                              placeholder: 'อีเมล',
                              errorMessage: _errorUsername,
                              onChanged: (val) {
                                setState(() {
                                  _registerModel.email = val;
                                  if (val != '' && _errorUsername != '') {
                                    _errorUsername = "";
                                  }
                                });
                              },
                            ),

                            Row(
                              children: [
                                Expanded(
                                    flex:1,
                                    child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const LabelText(
                                          text: 'ชื่อ',
                                        ),
                                      ],
                                    ),
                                    AppInput(
                                      placeholder: 'ชื่อ',
                                      onChanged: (val) {
                                        setState(() {
                                          _registerModel.fName = val;

                                        });
                                      },
                                    ),
                                  ],
                                )),
                                SizedBox(width: 20,),
                                Expanded(
                                    flex:1,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const LabelText(
                                              text: 'นามสกุล',
                                            ),
                                          ],
                                        ),
                                        AppInput(
                                          placeholder: 'นามสกุล',
                                          onChanged: (val) {
                                            setState(() {
                                              _registerModel.lName = val;

                                            });
                                          },
                                        ),
                                      ],
                                    ))
                              ],
                            ),

                            const SizedBox(
                              height:20.0,
                            ),

                            const LabelText(
                              text: 'รหัสผ่าน',
                            ),
                            AppInput(
                              obscureText: true,
                              placeholder: 'รหัสผ่าน',
                              errorMessage: _errorPwd,
                              onChanged: (val) {
                                setState(() {
                                  _registerModel.password = val;
                                  if (val != '' && _errorPwd != '') {
                                    _errorPwd = "";
                                  }
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const LabelText(
                              text: 'ยืนยันรหัสผ่าน',
                            ),
                            AppInput(
                              obscureText: true,
                              placeholder: 'ยืนยันรหัสผ่าน',
                              errorMessage: _errorPwd,
                              onChanged: (val) {
                                setState(() {
                                  _registerModel.rePassword = val;
                                  if (val != '' && _errorPwd != '') {
                                    _errorPwd = "";
                                  }
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                type: AppButtonType.primary,
                                text: 'สมัครสมาชิก',
                                onPressed:() async {
                                  if(
                                  _registerModel.email == '' ||
                                  _registerModel.password == ''||
                                  _registerModel.rePassword == ''||
                                  _registerModel.fName ==''||
                                  _registerModel.lName ==''
                                  ){
                                    final snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'กรอกข้อมูลให้ครบถ้วน!',
                                        titleFontSize: 16,
                                        messageFontSize: 14,
                                        message:
                                        'โปรดระบุข้อมูลให้ครบทุกช่อง',
                                        contentType: ContentType.failure,
                                      ),
                                    );

                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                    return;
                                  }
                                  if(_registerModel.password != _registerModel.rePassword){
                                    final snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'รหัสผ่านไม่ตรงกัน!',
                                        titleFontSize: 16,
                                        messageFontSize: 14,
                                        message:
                                        'โปรดระบุรหัสผ่านและยืนยันรหัสผ่านให้ตรงกัน',
                                        contentType: ContentType.failure,
                                      ),
                                    );

                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                    return;
                                  }
                                 AuthResponseModel result = await service.register(_registerModel);
                                 if(result.token!=null){
                                   Navigator.pushReplacement(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) =>
                                          MainPage(ownerId: result.userId!,)),
                                   );
                                 }else{
                                   final snackBar = SnackBar(
                                     elevation: 0,
                                     behavior: SnackBarBehavior.floating,
                                     backgroundColor: Colors.transparent,
                                     content: AwesomeSnackbarContent(
                                       title: 'ข้อมูลไม่ถูกต้อง!',
                                       titleFontSize: 16,
                                       messageFontSize: 14,
                                       message:
                                       'โปรดระบุข้อมูลผู้ใช้ให้ถูกต้อง',
                                       contentType: ContentType.failure,
                                     ),
                                   );

                                   ScaffoldMessenger.of(context)
                                     ..hideCurrentSnackBar()
                                     ..showSnackBar(snackBar);
                                 }

                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const LoginPage()),
                                  );
                                },
                                child: Center(child: LabelText( text:'เข้าสู่ระบบ',)))
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
