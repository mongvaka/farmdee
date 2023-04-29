import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/cupertino.dart';

class SwitchPage extends StatefulWidget {
  final String title;
  const SwitchPage({Key? key, required this.title}) : super(key: key);

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(title: widget.title, canBack: true,
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
    );
  }
}
