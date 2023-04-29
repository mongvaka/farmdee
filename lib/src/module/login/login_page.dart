import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_input.dart';
import 'login_model.dart';
import 'widgets/label_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final LoginModel _loginModel = LoginModel.fromJson({'username': '', 'password': ''});
  String _errorPwd = '';
  String _errorUsername = '';
  final TextEditingController _controllerUserName =
  TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      child: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/login-bg.png'),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      child: Image.asset(
                        'assets/images/2xhuatai_logo-wh.png',
                        fit: BoxFit.contain,
                      ),
                    ),
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
                              text: 'Username',
                              textColor: Colors.white,
                            ),
                            AppInput(
                              controller: _controllerUserName,
                              placeholder: 'username',
                              errorMessage: _errorUsername,
                              onChanged: (val) {

                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const LabelText(
                              text: 'Password',
                              textColor: Colors.white,
                            ),
                            AppInput(
                              obscureText: true,
                              placeholder: 'password',
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
                                text: 'Login',
                                onPressed:() {

                                   },
                              ),
                            ),
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
