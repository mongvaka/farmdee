import 'package:farmdee/src/module/login/login_page.dart';
import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/module/user/user_model.dart';
import 'package:farmdee/src/module/user/user_service.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:farmdee/src/widgets/text/caption_text.dart';
import 'package:farmdee/src/widgets/text/title_text.dart';
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
  List<Map<String, dynamic>> initOrderNotice = [
    {
      "name": "การจัดส่ง",
      "icon": "box.svg",
      "status": "BuyerConfirm",
      "value": 0
    },
    {
      "name": "ที่สำเร็จ",
      "icon": "delivery.svg",
      "status": "Completed",
      "value": 0
    },
    {
      "name": "การยกเลิก",
      "icon": "cancel_circle.svg",
      "status": "Canceled",
      "value": 0
    },
    {"name": "ให้คะแนน", "icon": "star.svg", "status": "Delivered", "value": 0},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserById();
    getNotification();
  }

  getUserById() {
    service.getById().then((value) {
      setState(() {
        model = value;
      });
    });
  }

  getNotification() async {
    List<Map<String, dynamic>> noti = await service.getOrderNotification();
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
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              TitleText(
                text: 'ภาพรวม',
                fontSize: 14,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.green.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset(
                        'assets/icons/sensor.svg',
                        color: Colors.white,
                        width: 45,
                        height: 45,
                      ),
                      Spacer(),
                      Column(
                        children: [
                          CaptionText(
                            text: 'เซ็นเซอร์',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          CaptionText(
                              text: '10',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                          CaptionText(
                              text: 'รายการ',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.green.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset(
                        'assets/icons/chip.svg',
                        color: Colors.white,
                      ),
                      Spacer(),
                      Column(
                        children: [
                          CaptionText(
                              text: 'ตัวควบคุม',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                          CaptionText(
                              text: '10',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                          CaptionText(
                              text: 'รายการ',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset(
                        'assets/icons/light.svg',
                        color: Colors.white,
                      ),
                      Spacer(),
                      Column(
                        children: [
                          CaptionText(
                            text: 'วัดค่าแสง',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          CaptionText(
                              text: '-',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                          CaptionText(
                              text: 'รายการ',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset(
                        'assets/icons/temperature.svg',
                        color: Colors.white,
                      ),
                      Spacer(),
                      Column(
                        children: [
                          CaptionText(
                              text: 'วัดอุณภูมิ',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                          CaptionText(
                              text: '-',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                          CaptionText(
                              text: 'รายการ',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset(
                        'assets/icons/humidity.svg',
                        width: 35,
                        height: 35,
                        color: Colors.white,
                      ),
                      Spacer(),
                      Column(
                        children: [
                          CaptionText(
                              text: 'วัดความชื้น',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                          CaptionText(
                              text: '-',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                          CaptionText(
                              text: 'รายการ',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              TitleText(
                text: 'ข้อมูลผู้ใช้',
                fontSize: 14,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TitleText(
                          text: 'อีเมล',
                          fontSize: 14,
                          color: Colors.white,
                        )),
                    Expanded(
                        flex: 1,
                        child: TitleText(
                            text: model.email,
                            fontSize: 14,
                            color: Colors.white)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TitleText(
                            text: 'ชื่อ', fontSize: 14, color: Colors.white)),
                    Expanded(
                        flex: 1,
                        child: TitleText(
                            text: model.firstName ?? '',
                            fontSize: 14,
                            color: Colors.white)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TitleText(
                            text: 'นามสกุล',
                            fontSize: 14,
                            color: Colors.white)),
                    Expanded(
                        flex: 1,
                        child: TitleText(
                            text: model.lastName ?? '',
                            fontSize: 14,
                            color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              TitleText(
                text: 'ข้อมูลการสั่งซื้อ',
                fontSize: 14,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getOrderOptionCard(),
            // children: getOrderOptionCard(),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              TitleText(
                text: 'ดำเนินการ',
                fontSize: 14,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             ...getOperationCard()
           ],
         )
        ]),
      ),
    );
  }

  List<Widget> getOrderOptionCard() {
    return initOrderNotice.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderPage(
                      status: e['status'],
                  initialIndex:initOrderNotice.indexOf(e) ,
                    )),
          );
        },
        child: Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Stack(
            children: [
              Center(
                child: Container(
                  child: Column(
                    children: [
                      Spacer(),
                      SvgPicture.asset(
                        'assets/icons/${e["icon"]}',
                        color: Colors.grey,
                        width: 20,
                        height: 20,
                      ),
                      CaptionText(text: '${e["name"]}'),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              e['value'] == 0
                  ? SizedBox()
                  : Positioned(
                      left: 20,
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

  List<Widget> getOperationCard() {
    return [
      GestureDetector(
        onTap: () async {
          final LocalStorage storage = new LocalStorage('auth');
          await storage.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        child: Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Spacer(),
                    SvgPicture.asset(
                      'assets/icons/logout.svg',
                      color: Colors.grey,
                      width: 20,
                      height: 20,
                    ),
                    CaptionText(text: 'ออกจากระบบ'),
                    Spacer(),
                  ],
                ),
              ),
            )),
      )
    ];
  }
}
