import 'package:farmdee/src/module/login/login_page.dart';
import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/module/user/user_model.dart';
import 'package:farmdee/src/module/user/user_service.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:farmdee/src/widgets/text/caption_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localstorage/localstorage.dart';
import '../order/order_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserModel model = UserModel(lastName: '', firstName: '', email: '');
  UserService service = UserService();
  List<Map<String,dynamic>> initOrderNotice = [
    {
      "name": "การจัดส่ง",
      "icon":"box.svg",
      "status":"BuyerConfirm",
      "value":0
    },
    {
      "name": "ที่สำเร็จ",
      "icon":"delivery.svg",
      "status":"Completed",
      "value":0
    },
    {
      "name": "การยกเลิก",
      "icon":"cancel_circle.svg",
      "status":"Canceled",
      "value":0
    },
    {
      "name": "ให้คะแนน",
      "icon":"star.svg",
      "status":"Delivered",
      "value":0

    },
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserById();
    getNotification();
  }
  getUserById() {
    service.getById().then((value){

      setState(() {
        model = value;
      });
    });
  }
  getNotification() async{
    List<Map<String,dynamic>> noti = await service.getOrderNotification();
    print(noti);
    setState(() {
      initOrderNotice = noti;
    });

  }
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(
      tailing: SizedBox(),
      title: 'ข้อมูลผู้ใช้',
      canBack: false,
      child: Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            Divider(
                color: Colors.black
            ),
            Row(children: [
              LabelText(text: 'อีเมล'),
              Spacer(),
              LabelText(text: model.email),
            ],),
            Divider(
                color: Colors.black
            ),
            Row(children: [
              LabelText(text: 'ชื่อ'),
              Spacer(),
              LabelText(text: model.firstName??''),
            ],),
            Divider(
                color: Colors.black
            ),
            Row(children: [
              LabelText(text: 'นามสกุล'),
              Spacer(),
              LabelText(text: model.lastName??''),
            ],),

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:getOrderOptionCard(),
              // children: getOrderOptionCard(),
            ),
            SizedBox(height: 10,),
            GestureDetector(
            onTap: () async{
              final LocalStorage storage = new LocalStorage('auth');
              await storage.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: LabelText(text: 'ออกจากระบบ',),
          )]
        ),
      ),
    );
  }
 List<Widget> getOrderOptionCard() {
    return initOrderNotice.map((e) {
      return GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderPage(status: e['status'],)),
          );
        },
        child: Container(
          width: 80,
          height: 50,
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/${e["icon"]}',
                      color: Colors.grey,
                      width: 20,
                      height: 20,
                    ),
                    CaptionText(text: '${e["name"]}')
                  ],
                ),
              ),
              e['value'] ==0?SizedBox():  Positioned(
                left:5,
                child: new Container(
                  padding: EdgeInsets.all(3),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: new Text(
                    '${e['value']}',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
                        ],
          ),
        ),
      );
    }).toList();
  }
}
