import 'package:flutter/cupertino.dart';

class LabelText extends StatelessWidget {
  final String text;
  final Color? textColor;
  const LabelText({super.key, required this.text, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
        style: textColor != null ? TextStyle(color: textColor,fontSize: 16,decoration: TextDecoration.none) : null,
      ),
    );
  }
}
