import 'package:farmdee/src/module/search_hardware/search_hardware_model.dart';
import 'package:farmdee/src/module/search_hardware/search_hardware_service.dart';
import 'package:farmdee/src/module/search_hardware/widgets/search_hardware_card.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';
import 'package:http/http.dart' as http;

import '../../shared/basic_function.dart';
import '../../widgets/app_input.dart';
import '../../widgets/scaffold/widgets/app_top_save_button.dart';
import '../login/widgets/label_text.dart';

class SearchHardwarePage extends StatefulWidget {

  const SearchHardwarePage({Key? key}) : super(key: key);

  @override
  State<SearchHardwarePage> createState() => _SearchHardwarePageState();
}

class _SearchHardwarePageState extends State<SearchHardwarePage> {
  List<SearchHardwareModel> _hardwareList = [];
  SearchHardwareService service = SearchHardwareService();
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  void _loadData() async {
    const port = 80;
    final stream = NetworkAnalyzer.discover2(
      '192.168.1', port,
      timeout: Duration(milliseconds: 5000),
    );

    List<String> keyFound = [];
    stream.listen((NetworkAddress addr) async {
      print(addr);
      if (addr.exists) {
        Response result = await http.get(
          Uri.parse('http://${addr.ip}/somewhere'),
        );
        if(isNumeric(result.body)){
          print('Found result ip ${addr.ip} : ${result.body} ');
          keyFound.add(result.body.toString().replaceAll("\n", "").replaceAll("\r", ""));
        }
      }
    }).onDone(() {
      service.list(keyFound).then((value){
        setState(() {
          print('lllll');
          loaded = true;
          _hardwareList = value;

        });
      });
    } );

  }
  String? codeDialog;
  String? valueText;
  final TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context,SearchHardwareModel m) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  LabelText( text: 'ผู้ใช้ : ${m.owner?.email}'),
            content:
            Container(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelText(text: 'รหัสผ่าน :'),
                  AppInput(
                    obscureText: true,
                    placeholder: 'ยืนยันรหัสผ่าน',
                    onChanged: (val) {
                      setState(() {
                        valueText = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              AppTopSaveButton(text: 'ยืนยัน',onPressed: () async{
                codeDialog = valueText;
                SearchHardwareModel? result = await service.activate(m.key, m.owner!.email, codeDialog);
                Navigator.pop(context);
              },)
            ],
          );
        });
  }
  bool loaded = false ;
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem( title: 'ค้นหาอุปกรณ์', canBack: true,
      child: Column(
        children: [
          Expanded(
            child: _hardwareList!.isNotEmpty
                ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _hardwareList?.length,
                itemBuilder: (_, index) {
                  SearchHardwareModel model = _hardwareList![index];
                  return SearchHardwareCard(
                      onPress: (SearchHardwareModel model) {

                      },
                      onRegister: (SearchHardwareModel model) async {
                        final LocalStorage storage = LocalStorage('auth');
                        int? ownerId =  storage.getItem('id');
                        if(model.ownerId!=0&& model.ownerId!= ownerId){
                          _displayTextInputDialog(context,model);
                        }else{
                          SearchHardwareModel? result = await service.activate(model.key, null, null);
                          if(result!=null){
                           int index =   _hardwareList.indexWhere((element) => element.key==result.key);
                           setState(() {
                             _hardwareList[index] = result;
                           });
                          }else{
                            print('Cannot Activate');
                          }
                        }
                      },
                      model:model

                  );
                })
                :(_hardwareList.isEmpty&&!loaded)? const Center(child: CupertinoActivityIndicator()):Center(child: LabelText(text: 'ไม่มีข้อมูล',),),
          ),

        ],
      ),
    );
  }
}

