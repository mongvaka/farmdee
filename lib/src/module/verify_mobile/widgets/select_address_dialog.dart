import 'package:farmdee/src/widgets/dialogs/app_bottom_dialog.dart';
import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/material.dart';

import '../../../shared/basic_respones.dart';
import '../model/address_option_model.dart';

class SelectAddressDialog extends StatelessWidget {
  final String title;
  final BasicResponse<AddressOptionModel> respons;
  const SelectAddressDialog(
      {Key? key, required this.title, required this.respons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBottomDialog(
      title: title,
      child: Column(
        children: [
          ...respons.content!.map((e) => GestureDetector(
                onTap: () {
                  Navigator.pop(context, e);
                },
                child: Column(
                  children: [
                    Container(padding: EdgeInsets.only(left: 60,right: 60),child: Divider(color: Colors.black,)),
                    Container(
                      child: Row(
                        children: [
                          Spacer(),
                          TitleText(text: e.name),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
