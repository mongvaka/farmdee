import 'package:farmdee/src/module/bucket/bucket_service.dart';
import 'package:farmdee/src/module/bucket/model/bucket_model.dart';
import 'package:farmdee/src/module/bucket/widget/bucket_card.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:farmdee/src/widgets/text/caption_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/text/detail_text.dart';
import '../home/home_search.dart';
import '../login/widgets/label_text.dart';

class BucketPage extends StatefulWidget {
  const BucketPage({Key? key}) : super(key: key);

  @override
  State<BucketPage> createState() => _BucketPageState();
}

class _BucketPageState extends State<BucketPage> {
  int currentSegment = 0;
  HomeSearch search = HomeSearch();
  BucketService service = BucketService();
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List<BucketModel> _posts = [];
  void _loadMore() async {
    if (search.page.last == false &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      search.page.offset += 1;

      try {
        final res = await service.list(search);
        print(res);
        search.fromResponse(res);
        final fetchedPosts = res.content;
        if (fetchedPosts!.isNotEmpty) {
          setState(() {
            _posts!.addAll(fetchedPosts);
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res = await service.list(search);
      print(res);
      search.fromResponse(res);
      setState(() {
        if(res.content !=null){
          _posts = res!.content!;
        }
      });
    } catch (err,t) {
      if (kDebugMode) {
        print(t);
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(
      tailing: SizedBox(),
      title: 'ตะกร้าสินค้า',
      canBack: true,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            _posts!.isNotEmpty
                ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _posts?.length,
                controller: _controller,
                itemBuilder: (_, index) {
                  BucketModel model = _posts![index];
                  return BucketCard(
                    onIncreaseAmount: (m){

                    },
                    onOptionChange: (m){

                    },
                    onSwitchActive: (m){

                    },
                    model: model,
                      // onPress: (HomeModel model) {
                      //
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             SwitchPage(homeModel: model)),
                      //   ).then((value){
                      //     _firstLoad();
                      //     _controller = ScrollController()..addListener(_loadMore);
                      //   });
                      //   // final router = context.router;
                      //   // router.push(ClientDetailRoute(clientId: clientId));
                      // },
                      // onPressSwitch: (HomeModel model) {
                      //   service.switchStatus(model);
                      // },
                      // model:model

                  );
                })
                :!_posts.isEmpty? const Center(child: CupertinoActivityIndicator()):Center(child: LabelText(text: 'ไม่มีข้อมูล',),),
            // SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //       BucketCard(),
            //
            //     ],
            //   ),
            // ),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(top: 7,bottom: 7),

                        color: Colors.white,
                        child: Row(children: [
                          Spacer(),
                          Column(
                            children: [
                              CaptionText(text: 'รวม 1200 บาท',),
                              CaptionText(text: '(12 รายการ)',),
                            ],
                          ),
                          Spacer(),
                        ],),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        child: Row(children: [
                          Spacer(),

                          DetailText(text: 'สั่งซื้อ',color: Colors.white,),
                          Spacer(),
                        ],),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
