import 'package:farmdee/src/module/login/login_service.dart';
import 'package:farmdee/src/module/login/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:localstorage/localstorage.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_input.dart';
import '../../widgets/app_input_email.dart';
import '../main/main_page.dart';
import 'login_model.dart';
import 'widgets/label_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerUserName =
      TextEditingController(text: '');
  final LoginModel _loginModel =
      LoginModel.fromJson({'username': '', 'password': ''});
  String _errorPwd = '';
  String _errorUsername = '';
  LoginService service = LoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
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
                                  _loginModel.email = val;
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
                                  _loginModel.password = val;
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
                                text: 'เข้าสู่ระบบ',
                                onPressed: () async {
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //       const MainPage()),
                                  // );
                                  service.login(_loginModel).then((value) {
                                    print('loginComplete : ${value.token}');
                                    if (value.token != null) {
                                      // Navigator.pushAndRemoveUntil(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => MainPage()
                                      //     ),
                                      //     ModalRoute.withName("/Home")
                                      // );
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainPage(
                                                  ownerId: value.userId!,
                                                )),
                                      );
                                    } else {
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
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()),
                                  );
                                },
                                child: Center(
                                    child: LabelText(
                                  text: 'สมัครสมาชิก',
                                )))
                          ],
                        )),
                    // const SizedBox(
                    //   height: 20.0,
                    // ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    // CaptionText(text: 'หรือ',fontSize: 10,textColor: Colors.black,),
                    // const SizedBox(
                    //   height: 10.0,
                    // ),
                    // Column(
                    //   children: [
                    //     SocialLoginButton(
                    //       height: 50,
                    //       buttonType: SocialLoginButtonType.facebook,
                    //       onPressed: () {},
                    //       borderRadius: 30,
                    //       text: 'ลงทะเบียนด้วย Facebook',
                    //     ),
                    //     SizedBox(height: 10,),
                    //     SocialLoginButton(
                    //       height: 50,
                    //       text: 'ลงทะเบียนด้วย Google',
                    //       borderRadius: 30,
                    //       buttonType: SocialLoginButtonType.google,
                    //       onPressed: () {},
                    //     ),
                    //   ],
                    // )
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
