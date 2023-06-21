import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart' as constants;

class AppInputEmail extends StatefulWidget {
  final bool? obscureText;
  final String? placeholder;
  final String? errorMessage;
  final String? Function(String value)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  EdgeInsets margin;
  Color borderColor;
  Color textColor;
  AppInputEmail(
      {super.key,
        this.obscureText,
        this.placeholder,
        this.validator,
        this.errorMessage,
        this.onChanged,
        this.controller,
        this.margin = const EdgeInsets.only(top: 0, bottom: 0),
        this.borderColor =  Colors.grey,
        this.textColor =  Colors.black87
      });
  @override
  State<AppInputEmail> createState() => _AppInputEmailState();
}

class _AppInputEmailState extends State<AppInputEmail> {
  bool _visiblePwd = false;
  late bool _obscureText;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? false;
    _visiblePwd = _obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CupertinoTextFormFieldRow (
          style:  TextStyle(color:widget.textColor,height: 1.7),
          onChanged: widget.onChanged,
          controller: widget.controller,
          padding: widget.margin,
          validator: (value)=>EmailValidator.validate(value==null?'':value!) ? null : "โปรดระบุ Email ให้ถูกต้อง",
          decoration: BoxDecoration(
            // backgroundBlendMode: BlendMode.hardLight,
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(255, 255, 255, 0.1),
                Color.fromRGBO(255, 255, 255, 0.1)
              ]),
              // backgroundBlendMode: const Color.fromRGBO(255, 255, 255, 0.1),
              border: Border.all(color: widget.borderColor),

              borderRadius: const BorderRadius.all(Radius.circular(10))),
          obscureText: _visiblePwd,
          placeholder: widget.placeholder,
          placeholderStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        widget.errorMessage != null
            ? Text(
          widget.errorMessage!,
          style: const TextStyle(
              color: CupertinoColors.systemRed, fontSize: 14),
        )
            : Container(),
      ],
    );
  }
}
