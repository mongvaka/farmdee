// ignore_for_file: deprecated_member_use, package_api_docs, public_member_api_docs
import 'package:farmdee/src/module/connect_wifi/set_wifi_service.dart';
import 'package:farmdee/src/utils/constants.dart';
import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'dart:io' show Platform;

import '../search_hardware/search_hardware_page.dart';
import 'model/name_password_model.dart';
import 'widgets/get_wifi_password_dialog.dart';

const String STA_DEFAULT_SSID = "STA_SSID";
const String STA_DEFAULT_PASSWORD = "STA_PASSWORD";
const NetworkSecurity STA_DEFAULT_SECURITY = NetworkSecurity.WPA;

const String AP_DEFAULT_SSID = "AP_SSID";
const String AP_DEFAULT_PASSWORD = "AP_PASSWORD";

class FlutterWifiIoT extends StatefulWidget {
  @override
  _FlutterWifiIoTState createState() => _FlutterWifiIoTState();
}

class _FlutterWifiIoTState extends State<FlutterWifiIoT> {
  String? _sPreviousAPSSID = "";
  String? _sPreviousPreSharedKey = "";
  String? sAPSSID;
  String? sPreSharedKey;
  List<WifiNetwork?>? _htResultNetwork;
  Map<String, bool>? _htIsNetworkRegistered = Map();
  var _isSucceed = false;

  bool _isEnabled = false;
  bool _isConnected = false;
  bool _isWiFiAPEnabled = false;
  bool _isWiFiAPSSIDHidden = false;
  bool _isWifiAPSupported = true;
  bool _isWifiEnableOpenSettings = false;
  bool _isWifiDisableOpenSettings = false;
  String nameWifi ='';
  SetWifiService service = SetWifiService();
  WifiAndPassword wifiModel = WifiAndPassword(wifiName: '',wifiPassword: '',bssid: '');
  final TextStyle textStyle = TextStyle(color: Colors.white);
  List<WifiNetwork> htResultNetwork =[];
  void _requestConnectWifi() async {
    WiFiForIoTPlugin.isEnabled().then((val) {
      _isEnabled = val;
      if(!_isEnabled){
        WiFiForIoTPlugin.setEnabled(true,shouldOpenSettings: true);
        return;
      }
    });

    WiFiForIoTPlugin.isConnected().then((val) {
      _isConnected = val;
    });
    loadWifiList();
  }
  @override
  initState() {
    _requestConnectWifi();
    // WiFiForIoTPlugin.isWiFiAPEnabled().then((val) {
    //   _isWiFiAPEnabled = val;
    // }).catchError((val) {
    //   _isWifiAPSupported = false;
    // });

    super.initState();
  }

  storeAndConnect(String psSSID, String psKey) async {
    await storeAPInfos();
    await WiFiForIoTPlugin.setWiFiAPSSID(psSSID);
    await WiFiForIoTPlugin.setWiFiAPPreSharedKey(psKey);
  }

  storeAPInfos() async {
    String? sAPSSID;
    String? sPreSharedKey;

    try {
      sAPSSID = await WiFiForIoTPlugin.getWiFiAPSSID();
    } on PlatformException {
      sAPSSID = "";
    }

    try {
      sPreSharedKey = await WiFiForIoTPlugin.getWiFiAPPreSharedKey();
    } on PlatformException {
      sPreSharedKey = "";
    }

    setState(() {
      _sPreviousAPSSID = sAPSSID;
      _sPreviousPreSharedKey = sPreSharedKey;
    });
  }

  restoreAPInfos() async {
    WiFiForIoTPlugin.setWiFiAPSSID(_sPreviousAPSSID!);
    WiFiForIoTPlugin.setWiFiAPPreSharedKey(_sPreviousPreSharedKey!);
  }
  Future<List<String>> getWiFiAPInfos() async {

    try {
      String? _sAPSSID = await WiFiForIoTPlugin.getSSID();
      setState(() {
        sAPSSID = _sAPSSID;
      });
    } catch(e){
      sAPSSID = "";
    }

    try {
      String? _sPreSharedKey = await WiFiForIoTPlugin.getBSSID();
      setState(() {
        sPreSharedKey = _sPreSharedKey;
      });
    } catch(e) {
      sPreSharedKey = "";
    }
    return [sAPSSID!, sPreSharedKey!];
  }

  // Future<WIFI_AP_STATE?> getWiFiAPState() async {
  //   int? iWiFiState;
  //
  //   WIFI_AP_STATE? wifiAPState;
  //
  //   try {
  //     iWiFiState = await WiFiForIoTPlugin.getWiFiAPState();
  //   } on Exception {
  //     iWiFiState = WIFI_AP_STATE.WIFI_AP_STATE_FAILED.index;
  //   }
  //
  //   if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_DISABLING.index) {
  //     wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_DISABLING;
  //   } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_DISABLED.index) {
  //     wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_DISABLED;
  //   } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_ENABLING.index) {
  //     wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_ENABLING;
  //   } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_ENABLED.index) {
  //     wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_ENABLED;
  //   } else if (iWiFiState == WIFI_AP_STATE.WIFI_AP_STATE_FAILED.index) {
  //     wifiAPState = WIFI_AP_STATE.WIFI_AP_STATE_FAILED;
  //   }
  //
  //   return wifiAPState!;
  // }

  // Future<List<APClient>> getClientList(
  //     bool onlyReachables, int reachableTimeout) async {
  //   List<APClient> htResultClient;
  //
  //   try {
  //     htResultClient = await WiFiForIoTPlugin.getClientList(
  //         onlyReachables, reachableTimeout);
  //   } on PlatformException {
  //     htResultClient = <APClient>[];
  //   }
  //
  //   return htResultClient;
  // }

  Future<List<WifiNetwork>> loadWifiList() async {
    try {
      List<WifiNetwork> _htResultNetwork = await WiFiForIoTPlugin.loadWifiList();
      setState(() {
        htResultNetwork =_htResultNetwork;
      });
    } on PlatformException {
      htResultNetwork = <WifiNetwork>[];
    }

    return htResultNetwork;
  }

  isRegisteredWifiNetwork(String ssid) async {
    bool bIsRegistered;

    try {
      bIsRegistered = await WiFiForIoTPlugin.isRegisteredWifiNetwork(ssid);
    } on PlatformException {
      bIsRegistered = false;
    }

    setState(() {
      _htIsNetworkRegistered![ssid] = bIsRegistered;
    });
  }

  // void showClientList() async {
  //   /// Refresh the list and show in console
  //   getClientList(false, 300).then((val) => val.forEach((oClient) {
  //     print("************************");
  //     print("Client :");
  //     print("ipAddr = '${oClient.ipAddr}'");
  //     print("hwAddr = '${oClient.hwAddr}'");
  //     print("device = '${oClient.device}'");
  //     print("isReachable = '${oClient.isReachable}'");
  //     print("************************");
  //   }));
  // }


  @override
  Widget build(BuildContext poContext) {
    return MaterialApp(

      home: SafeArea(
        child: Scaffold(

          body: Column(
            children: [
              SizedBox(height: 15,),
              TitleText(text: 'เลือกเครือข่ายสำหรับอุปกรณ์',color: TEXT_COLOR,fontSize: 18,fontWeight: FontWeight.w600,),
              SizedBox(height: 15,),
              ...htResultNetwork.map((e) {
                return GestureDetector(
                  onTap: (){
                    // WifiManager wifiManager = (WifiManager) this.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
                    // wifiManager.setWifiEnabled(true);
                    // wifiManager.setWifiEnabled(false);
                    // boolean wifiEnabled = wifiManager.isWifiEnabled()
                    if(!_isEnabled){
                      WiFiForIoTPlugin.setEnabled(true,shouldOpenSettings: true);
                      return;
                    }
                    // nameWifi = e.ssid!;
                    // wifiModel.wifiName = e.ssid!;
                    // wifiModel.bssid = e.bssid!;
                    showModal(context);
                    // service.getWifi();
                    // service.setWifi('Repeater', '88888888');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: TitleText(text:e.ssid!)),
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
          return GetPasswordWifiDialog(onPasswordChang: (password){
            wifiModel.wifiPassword = password;
          }, );
        }).whenComplete(() {
      print('whenComplete');
    }).then(( value) async {
      if(value!=null){
        // print('vonnect : ${value}');
        // print('whenconectnameWifi : ${nameWifi}');
        //
        // wifiModel = value;
        print('wifi : ${wifiModel.wifiName} password : ${wifiModel.wifiPassword} bssid : ${wifiModel.bssid}');
        // final isSucceed =
        // await WifiConnector.connectToWifi(ssid: wifiModel.wifiName, password: wifiModel.wifiPassword);
        // setState(() => _isSucceed = isSucceed);

        // WiFiForIoTPlugin.disconnect();
        WiFiForIoTPlugin.connect(wifiModel.wifiName,bssid:wifiModel.bssid ,password: wifiModel.wifiPassword,isHidden: true,security: NetworkSecurity.WPA).then((value) {
          setState(() {
            _isSucceed = value;
            connectApIotAndSetWifiPassword();
          });
          
        });

        // _htResultNetwork?.forEach((el) {
        //   if(el!.ssid!.contains('Ap')){
        //    WiFiForIoTPlugin.connect(wifiModel.wifiName,password: wifiModel.wifiPassword);
        //   }
        // });

      }


    });
  }

  void connectApIotAndSetWifiPassword() {
    htResultNetwork.forEach((el) async {
      print('el.ssid : ${el.ssid}');
      if(el.ssid =='AutoConnectAP'){
        print('result Is Equal : ${el.ssid}');
        await WiFiForIoTPlugin.connect(el.ssid!,bssid:el.bssid ,isHidden: true,security: NetworkSecurity.NONE);
        bool? result = await service.setWifi(wifiModel.wifiName, wifiModel.wifiPassword);
        print('result : $result');
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
          const SearchHardwarePage()),
    );
  }


}

class PopupCommand {
  String command;
  String argument;

  PopupCommand(this.command, this.argument);
}