import 'package:farmdee/src/module/switch/switch_model.dart';
import 'package:farmdee/src/module/switch/widgets/switch_card.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/app_input.dart';
import '../login/widgets/label_text.dart';

class SwitchPage extends StatefulWidget {
  final String title;
  const SwitchPage({Key? key, required this.title}) : super(key: key);

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerName =
  TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(title: widget.title, canBack: true,
      onPressSubmit: (){

      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppInput(
                        textColor: Colors.grey,
                        borderColor:Colors.grey,
                        controller: _controllerName,
                        placeholder: 'ชื่อ',
                        onChanged: (val) {
                          _controllerName.text = val;
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: LabelText(text: 'ตารางงาน',textColor:Colors.black,),
                            ),
                            Spacer(),
                            Container(
                              padding: const EdgeInsets.only(left: 18,right: 10),
                              width: 45,
                              color: const Color.fromRGBO(245, 246, 248, 0.8),
                              child: SvgPicture.asset(
                                'assets/icons/left.svg',
                              ),
                            )
                          ],
                        ),
                      ),
                      SwitchCard(onPressDelete: (model){}, onStartTimeChange: (model){}, onEndTimeChange: (model){}, model: new SwitchModel(id: 1, startTime: '10:11', endTime: '11:11'))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
