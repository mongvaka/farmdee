import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';
import '../../widgets/scaffold/app_scaffold_item.dart';
import '../../widgets/scaffold/app_scaffold_list.dart';
import 'home_model.dart';
import 'home_search.dart';
import 'home_service.dart';
import 'widgets/home_card.dart';
import 'widgets/home_filter_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentSegment = 0;
  HomeSearch search = HomeSearch();
  HomeService service = HomeService();
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List<HomeModel> _posts = [];
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
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
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
      canBack: false,
      title: 'รายการทั้งหมด',
      child: Column(
        children: [
          Expanded(
            child: _posts!.isNotEmpty
                ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _posts?.length,
                controller: _controller,
                itemBuilder: (_, index) {
                  HomeModel model = _posts![index];
                  return HomeCard(
                    onPress: (HomeModel model) {
                      // final router = context.router;
                      // router.push(ClientDetailRoute(clientId: clientId));
                    },
                    onPressSwitch: (HomeModel model) {
                      service.switchStatus(model);
                    },
                    model:model

                  );
                })
                : const Center(child: CupertinoActivityIndicator()),
          ),
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 1, bottom: 1),
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void showModal(context) {
    String sort = search.page.sortBy;
    String order = search.page.orderBy;
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return HomeFilterDialog(
            onSortBy: (sortKey) {
              sort = sortKey;
            },
            onFilter: (filter){

            },
            onOrdering: (orderKey) {
              order = orderKey;
            },
            orderingValue: order,
            sortValue: search.page.sortBy,
          );
        }).whenComplete(() {
      if (
          search.page.sortBy != sort ||
          search.page.orderBy != order) {
        search.clearPaginate();

        search.page.sortBy = sort;
        search.page.orderBy = order;
        _firstLoad();
        _posts = [];
      }
    });
  }
}

class ClientStyle {
  static final clientTabStyle = GoogleFonts.inter(
      textStyle: const TextStyle(
          fontSize: 16,
          color: TEXT_COLOR,
          overflow: TextOverflow.clip,
          decoration: TextDecoration.none));
}