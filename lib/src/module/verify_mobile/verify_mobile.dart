import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_input.dart';
import '../login/widgets/label_text.dart';

class VerifyMobile extends StatefulWidget {
  const VerifyMobile({Key? key}) : super(key: key);

  @override
  State<VerifyMobile> createState() => _VerifyMobileState();
}

class _VerifyMobileState extends State<VerifyMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                TitleText(text: 'ที่อยู่ในการจัดส่ง',fontSize: 14,),
                Spacer(),
              ],
            ),
            const LabelText(
              text: 'ที่อยู่',
            ),
            AppInput(
              placeholder: 'ที่อยู่',
              onChanged: (val) {
                setState(() {

                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
