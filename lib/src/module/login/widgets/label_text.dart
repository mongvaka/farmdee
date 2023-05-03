import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String text;
  const LabelText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.black ,fontSize: 16,decoration: TextDecoration.none,fontWeight: FontWeight.w600) ,
      ),
    );
  }
}
