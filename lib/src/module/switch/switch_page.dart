import 'package:farmdee/src/module/switch/switch_child_model.dart';
import 'package:farmdee/src/module/switch/switch_model.dart';
import 'package:farmdee/src/module/switch/switch_service.dart';
import 'package:farmdee/src/module/switch/widgets/switch_card.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../widgets/app_input.dart';
import '../../widgets/scaffold/widgets/app_top_save_button.dart';
import '../home/home_model.dart';
import '../login/widgets/label_text.dart';

class SwitchPage extends StatefulWidget {
  final HomeModel? homeModel;

 const SwitchPage({Key? key, required this.homeModel}) : super(key: key);



  @override
  State<SwitchPage> createState() => _SwitchPageState();

}

class _SwitchPageState extends State<SwitchPage> {
  SwitchModel model = SwitchModel(id:0,name: '', schedule: [],isManual:true);
  SwitchService service = SwitchService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName =TextEditingController(text: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service.getById(widget.homeModel!.id).then((result) {
      print(result);
      if(result != null){
        setState(() {
          model = result!;
          _controllerName = TextEditingController(text: model.name);
        });

      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(
      tailing: AppTopSaveButton(
        text:'บันทึก',
        onPressed: () async {
          bool result = await service.createSchedule(model);
          print(result);
          if(result){
            Navigator.pop(
              context,
            );
          }
        },
      ),
      title: 'รายละเอียด', canBack: true,


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
                          model.name = val;
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
                              child: LabelText(text: 'ทำงานอัตโนมัติ',),
                            ),
                            Spacer(),
                            FlutterSwitch(
                              width: 50,
                              height: 25,
                              inactiveTextFontWeight: FontWeight.w400,
                              activeTextFontWeight: FontWeight.w400,
                              valueFontSize: 16,
                              value: model.isManual,
                              onToggle: (val) {
                                setState(() {
                                  model.isManual = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: LabelText(text: 'ตารางงาน',),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  model.schedule.add(new SwitchChildModel(id: 0, startTime: '00:00:00', endTime: '00:05:00'));

                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 18,right: 10),
                                width: 45,
                                color: const Color.fromRGBO(245, 246, 248, 0.8),
                                child: SvgPicture.asset(
                                  'assets/icons/plus.svg',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      ...model.schedule.map((e) {
                        return SwitchCard(
                            onPressDelete: (m){
                              setState(() {
                                model.schedule.remove(m);

                              });
                            },
                            onStartTimeChange: (m){

                            },
                            onEndTimeChange: (m){},
                            model: e);
                      })

                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
