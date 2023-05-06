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
  final RegisterModel _registerModel = RegisterModel.fromJson({'email': '', 'password': '', 'rePassword': ''});
  String _errorPwd = '';
  String _errorUsername = '';
  RegisterService service = RegisterService();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      child: SafeArea(
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
                            const SizedBox(
                              height: 10.0,
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

                                 AuthResponseModel result = await service.register(_registerModel);
                                 if(result.token!=null){
                                   Navigator.pushReplacement(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) =>
                                         const MainPage()),
                                   );
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
