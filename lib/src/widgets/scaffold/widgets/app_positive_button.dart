import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

enum AppButtonType { primary, secondary }

class AppPositiveButton extends StatelessWidget {
  final String text;
  final AppButtonType? type;
  final Function() onPressed;
  const AppPositiveButton(
      {super.key, required this.text,required this.onPressed, this.type});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
          onPressed()
        },
        child: Text(
          text,
          style: TextStyle(color: Colors.white),

        ),
    );
  }
}
