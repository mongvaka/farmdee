import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoadingDialog extends StatefulWidget {
  const AppLoadingDialog({Key? key}) : super(key: key);

  @override
  State<AppLoadingDialog> createState() => _AppLoadingDialogState();
}

class _AppLoadingDialogState extends State<AppLoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return  const Center(child: CupertinoActivityIndicator());
  }
}

