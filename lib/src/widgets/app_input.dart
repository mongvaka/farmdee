import 'package:flutter/cupertino.dart';
import '../utils/constants.dart' as constants;

class AppInput extends StatefulWidget {
  final bool? obscureText;
  final String? placeholder;
  final String? errorMessage;
  final String? Function(String? value)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const AppInput(
      {super.key,
        this.obscureText,
        this.placeholder,
        this.validator,
        this.errorMessage,
        this.onChanged,
        this.controller});
  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
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
    const borderColor = Color.fromRGBO(255, 255, 255, 0.3);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CupertinoTextField(
          style: const TextStyle(color: CupertinoColors.white),
          onChanged: widget.onChanged,
          controller: widget.controller,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7.5),
          decoration: BoxDecoration(
            // backgroundBlendMode: BlendMode.hardLight,
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(255, 255, 255, 0.1),
                Color.fromRGBO(255, 255, 255, 0.1)
              ]),
              // backgroundBlendMode: const Color.fromRGBO(255, 255, 255, 0.1),
              border: Border.all(color: borderColor),
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
            color: Color.fromRGBO(255, 255, 255, 0.7),
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
