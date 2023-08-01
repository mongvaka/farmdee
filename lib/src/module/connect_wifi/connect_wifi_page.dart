import 'package:farmdee/src/module/connect_wifi/set_wifi_service.dart';
import 'package:farmdee/src/utils/constants.dart';
import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'model/name_password_model.dart';
import 'widgets/get_wifi_password_dialog.dart';

class FlutterWifiIoT extends StatefulWidget {
  const FlutterWifiIoT({super.key});

  @override
  _FlutterWifiIoTState createState() => _FlutterWifiIoTState();
}

class _FlutterWifiIoTState extends State<FlutterWifiIoT> {
  bool _isEnabled = false;
  String nameWifi = '';
  SetWifiService service = SetWifiService();
  WifiAndPassword wifiModel =
      WifiAndPassword(wifiName: '', wifiPassword: '', bssid: '');
  final TextStyle textStyle =const TextStyle(color: Colors.white);
  List<WifiNetwork> htResultNetwork = [];
  void _requestConnectWifi() async {
    WiFiForIoTPlugin.isEnabled().then((val) {
      _isEnabled = val;
      if (!_isEnabled) {
        WiFiForIoTPlugin.setEnabled(true, shouldOpenSettings: true);
        return;
      }
    });
    loadWifiList();
  }

  @override
  initState() {
    _requestConnectWifi();
    super.initState();
  }

  storeAndConnect(String psSSID, String psKey) async {}

  Future<List<WifiNetwork>> loadWifiList() async {
    try {
      List<WifiNetwork> _htResultNetwork =
          await WiFiForIoTPlugin.loadWifiList();
      setState(() {
        htResultNetwork = _htResultNetwork;
      });
    } on PlatformException {
      htResultNetwork = <WifiNetwork>[];
    }

    return htResultNetwork;
  }

  @override
  Widget build(BuildContext poContext) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              TitleText(
                text: 'เลือกเครือข่ายสำหรับอุปกรณ์',
                color: TEXT_COLOR,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 15,
              ),
              ...htResultNetwork.map((e) {
                return GestureDetector(
                  onTap: () async {
                    if (!_isEnabled) {
                      WiFiForIoTPlugin.setEnabled(true,
                          shouldOpenSettings: true);
                      return;
                    }
                    wifiModel.wifiName = e.ssid!;
                    wifiModel.bssid = e.bssid!;
                    showModal(context);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin:const EdgeInsets.only(left: 20, right: 20, top: 10),
                      padding:const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black26),
                          borderRadius:const BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: TitleText(text: e.ssid!)),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void showModal(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return GetPasswordWifiDialog(
            wifiName: wifiModel.wifiName,
            bssid: wifiModel.bssid,
            onPasswordChang: (password, wifiName, bssid) {
              wifiModel.wifiPassword = password;
              wifiModel.wifiName = wifiName;
              wifiModel.bssid = bssid;
            },
          );
        }).whenComplete(() {}).then((value) async {
      if (value != null) {
        service
            .setWifi(wifiModel.wifiName, wifiModel.wifiPassword)
            .then((value) {
          if (value) {
            Navigator.pop(
              context
            );
          }
        });
      }
    });
  }
}
