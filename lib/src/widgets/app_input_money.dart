import 'package:farmdee/src/utils/data_type_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart' as constants;

class AppInputMoney extends StatefulWidget {
  final bool? obscureText;
  final String? placeholder;
  final String? errorMessage;
  final String? Function(String? value)? validator;
  final void Function(double)? onChanged;
  final TextEditingController? controller;
   EdgeInsets margin;
  Color borderColor;
  Color textColor;
  AppInputMoney(
      {super.key,
        this.obscureText,
        this.placeholder,
        this.validator,
        this.errorMessage,
        this.onChanged,
        this.controller,
        this.margin = const EdgeInsets.symmetric(vertical: 12, horizontal: 7.5),
        this.borderColor =  Colors.grey,
        this.textColor =  Colors.black87
      });
  @override
  State<AppInputMoney> createState() => _AppInputState();
}

class _AppInputState extends State<AppInputMoney> {
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
        CupertinoTextField(
          style:  TextStyle(color:widget.textColor),
          onChanged:(val){
            widget.onChanged!(DataTypeHelper.toDouble(val));
          },
          keyboardType: TextInputType.number,
          controller: widget.controller,
          padding: widget.margin,
          decoration: BoxDecoration(
            // backgroundBlendMode: BlendMode.hardLight,
            //   gradient: const LinearGradient(colors: [
            //     Color.fromRGBO(255, 255, 255, 0.1),
            //     Color.fromRGBO(255, 255, 255, 0.1)
            //   ]),
              // backgroundBlendMode: const Color.fromRGBO(255, 255, 255, 0.1),
            color: Colors.white,
              border: Border.all(color: widget.borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          obscureText: _visiblePwd,
          suffixMode: _obscureText
              ? OverlayVisibilityMode.always
              : OverlayVisibilityMode.never,
          suffix: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                _visiblePwd ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                color: CupertinoColors.white,
              ),
            ),
            onTap: () {
              setState(() {
                _visiblePwd = !_visiblePwd;
              });
            },
          ),
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
