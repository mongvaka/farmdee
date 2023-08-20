import 'package:farmdee/src/module/login/login_page.dart';
import 'package:farmdee/src/module/user/model/edit_profile_model.dart';
import 'package:farmdee/src/module/user/model/sensor_count_model.dart';
import 'package:farmdee/src/module/user/user_model.dart';
import 'package:farmdee/src/module/user/user_service.dart';
import 'package:farmdee/src/utils/constants.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:farmdee/src/widgets/text/caption_text.dart';
import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localstorage/localstorage.dart';
import '../connect_wifi/connect_wifi_page.dart';
import '../order/order_page.dart';
import '../verify_mobile/verify_mobile.dart';
import 'edit_profile_page.dart';

class UserPage extends StatefulWidget {
  UserModel model = UserModel(lastName: '', firstName: '', email: '');
  SensorCountModel sensorCountModel = SensorCountModel.empty();
  UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
    getSensorCount();
  }

  getUserById() {
    service.getById().then((value) {
      setState(() {
        widget.model = value;
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
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                        color: Colors.blue,
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
                                text: '${widget.sensorCountModel.sensorCount}',
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
                        color: Colors.blue,
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
                                text: '${widget.sensorCountModel.controllerCount}',
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
                        color: Colors.blue,
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
                                text: '${widget.sensorCountModel.lightSensor}',
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
                        color: Colors.blue,
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
                                text: '${widget.sensorCountModel.tempSensor}',
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
                        color: Colors.blue,
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
                                text: '${widget.sensorCountModel.homSensor}',
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
                Spacer(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProfilePage(model: EditProfileModel(fName: widget.model.firstName,lName: widget.model.lastName),)),
                    ).then((value) {
                      getUserById();
                    });

                  },
                  child:TitleText(
                    text: 'แก้ไข',
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.green,
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
                              text: widget.model.email,
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
                              text: widget.model.firstName ?? '',
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
                              text: widget.model.lastName ?? '',
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
                  text: 'ที่อยู่จัดส่ง',
                  fontSize: 14,
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VerifyMobile()),
                    );
                    // VerifyMobile
                  },
                  child:TitleText(
                    text: 'แก้ไข',
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: TitleText(
                            text: 'เบอร์โทร',
                            fontSize: 14,
                            color: TEXT_COLOR,
                          )),
                      Expanded(
                          flex: 2,
                          child: TitleText(
                              text: widget.model.address?.phoneNumber??'',
                              fontSize: 14,
                              color: TEXT_COLOR)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: TitleText(
                            text: 'ที่อยู่',
                            fontSize: 14,
                            color: TEXT_COLOR,
                          )),
                      Expanded(
                          flex: 2,
                          child: TitleText(
                              text: widget.model.address?.address??'',
                              fontSize: 14,
                              color: TEXT_COLOR)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: TitleText(
                              text: 'ตำบล', fontSize: 14, color: TEXT_COLOR)),
                      Expanded(
                          flex: 2,
                          child: TitleText(
                              text: widget.model.address?.subDistrictName ?? '',
                              fontSize: 14,
                              color: TEXT_COLOR)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: TitleText(
                              text: 'อำเภอ',
                              fontSize: 14,
                              color: TEXT_COLOR)),
                      Expanded(
                          flex: 2,
                          child: TitleText(
                              text: widget.model.address?.districtName ?? '',
                              fontSize: 14,
                              color: TEXT_COLOR)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: TitleText(
                              text:'จังหวัด',
                              fontSize: 14,
                              color: TEXT_COLOR)),
                      Expanded(
                          flex: 2,
                          child: TitleText(
                              text: widget.model.address?.provinceName ?? '',
                              fontSize: 14,
                              color: TEXT_COLOR)),
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
           ),
            SizedBox(
              height: 10,
            ),
          ]),
        ),
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
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                 FlutterWifiIoT()),
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
                      'assets/icons/connect.svg',
                      color: Colors.grey,
                      width: 20,
                      height: 20,
                    ),
                    CaptionText(text: 'ต่ออุปกรณ์'),
                    Spacer(),
                  ],
                ),
              ),
            )),
      ),
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
      ),

    ];
  }

  void getSensorCount() {
    service.getSensorCount().then((value) {
      setState(() {
        widget.sensorCountModel = value;
      });
    });
  }
}
