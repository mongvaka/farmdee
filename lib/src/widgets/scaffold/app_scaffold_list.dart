import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants.dart';

class AppScaffoldList extends StatelessWidget {
  final Function onPressFilter;
  final Function onPressSearch;
  final Widget child;
  const AppScaffoldList({Key? key, required this.onPressFilter, required this.onPressSearch, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: BACKGROUND_COLOR,
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        backgroundColor: BACKGROUND_COLOR,
        automaticallyImplyLeading: false,
        border: null,
        middle: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CupertinoSearchTextField(
            onTap: () {
              onPressSearch();
            },
            decoration: BoxDecoration(
                color: SEARCH_BACKGROUND_COLOR,
                border: Border.all(
                  color: SEARCH_BACKGROUND_BORDER_COLOR,
                ),
                borderRadius: BorderRadius.circular(10)),
            style: const TextStyle(fontSize: 16),
            placeholder: 'Search',
            keyboardType: TextInputType.none,
            enabled: true,
          ),
        ),
        trailing: GestureDetector(
            onTap: () {
              onPressFilter();
            },
            child:Container(
              padding:const EdgeInsets.only(left: 5,right: 15),
              width: 45,
              color: const Color.fromRGBO(245, 246, 248, 0.8),
              child: SvgPicture.asset(
                'assets/icons/filter.svg',

              ),
            )
        ),
      ),
      child: child,
    );
  }
}
