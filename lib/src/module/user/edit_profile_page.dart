import 'package:farmdee/src/module/user/model/edit_profile_model.dart';
import 'package:farmdee/src/module/user/user_service.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_input.dart';

class EditProfilePage extends StatefulWidget {
  final EditProfileModel model;
  const EditProfilePage({Key? key, required this.model}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserService service = UserService();
  @override
  Widget build(BuildContext context) {
    return  AppScaffoldItem(
      title: 'แก้ไขข้อมูลผู้ใช้',
      canBack: true,
      tailing:  SizedBox(),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Spacer(),
            AppInput(
              placeholder: 'ชื่อ',
              onChanged: (val) {
                setState(() {
                  widget.model.fName = val;
                });
              },
            ),
            SizedBox(height: 20,),
            AppInput(
              placeholder: 'สกุล',
              onChanged: (val) {
                setState(() {
                  widget.model.lName = val;
                });
              },
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              child: AppButton(
                type: AppButtonType.primary,
                text: 'บันทึกการแก้ไข',
                onPressed:() async {
                  service.editUserProfile(widget.model).then((value){
                    if(value){
                      Navigator.pop(
                        context,
                      );
                    }
                  });
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
