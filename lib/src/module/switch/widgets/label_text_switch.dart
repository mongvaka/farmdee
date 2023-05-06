import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabelTextSwitch extends StatelessWidget {
  final String text;
  const LabelTextSwitch({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.grey ,fontSize: 14,decoration: TextDecoration.none,fontWeight: FontWeight.w500) ,
      ),
    );
  }
}
