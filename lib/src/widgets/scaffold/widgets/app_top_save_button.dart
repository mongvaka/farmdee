import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

enum AppButtonType { primary, secondary }

class AppTopSaveButton extends StatelessWidget {
  final String text;
  final AppButtonType? type;
  final Function()? onPressed;
  const AppTopSaveButton({super.key, required this.text, this.onPressed, this.type});

  @override
  Widget build(BuildContext context) {
    // final color =
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}
