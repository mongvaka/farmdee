import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/constants.dart';

class AppScaffoldSearch extends StatelessWidget {
  final Function(String) onSearchSubmit;
  final Widget child;
  const AppScaffoldSearch({Key? key, required this.onSearchSubmit, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: BACKGROUND_COLOR,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: BACKGROUND_COLOR,
        padding: EdgeInsetsDirectional.zero,
        leading: GestureDetector(
            onTap: () {

            },
            child: Container(
              padding:  EdgeInsets.only(left: 18,right: 10),
              width: 45,
              color: const Color.fromRGBO(245, 246, 248, 0.8),
              child: SvgPicture.asset(
                'assets/icons/left.svg',
              ),
            )
        ),
        border: null,
        middle: Padding(
          padding: EdgeInsets.only(left: 0, right: 12),
          child: CupertinoSearchTextField(
            onSubmitted: (searchText) {
              onSearchSubmit(searchText);
            },
            decoration: BoxDecoration(
                color: SEARCH_BACKGROUND_COLOR,
                border: Border.all(
                  color: SEARCH_BACKGROUND_BORDER_COLOR,
                ),
                borderRadius: BorderRadius.circular(10)),
            style: const TextStyle(fontSize: 16),
            placeholder: 'Search',
            autofocus: true,
          ),
        ),
      ),
      child:child,
    );
  }
}
