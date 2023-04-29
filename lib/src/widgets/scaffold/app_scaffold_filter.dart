import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class AppScaffoldFilter extends StatelessWidget {
  final Function onFilterComplete;
  final Function onReset;
  final Widget child;
  const AppScaffoldFilter({Key? key, required this.onFilterComplete, required this.onReset, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: const Color.fromRGBO(245, 246, 248, 0.8),
          padding: EdgeInsetsDirectional.zero,
          leading: GestureDetector(
              onTap: () {
                onFilterComplete();
                // setState(() {
                //   // add filters
                //   filters = [];
                //   if (countryFilters.isNotEmpty) {
                //     filters.add(BasicFilter(
                //         key: COUNTRY,
                //         operation: 'in',
                //         value: countryFilters.join(',')));
                //   }
                //
                //   if (accountFilters.isNotEmpty) {
                //     filters.add(BasicFilter(
                //         key: ACCOUNT_NO,
                //         operation: 'in',
                //         value: accountFilters.join(',')));
                //   }
                //
                //   if (productFilters.isNotEmpty) {
                //     filters.add(BasicFilter(
                //         key: PRODUCT,
                //         operation: 'in',
                //         value: productFilters.join(',')));
                //   }
                // });
                // context.router.pop(SummarySearch(
                //     clientId: widget.search.clientId,
                //     filters: filters,
                //     sortBy: selectedRadioSortBy,
                //     orderBy: selectedRadioOrderBy));
              },
              child:Container(
                padding: EdgeInsets.only(left: 18,right: 10),
                width: 45,
                color: const Color.fromRGBO(245, 246, 248, 0.8),
                child: SvgPicture.asset(
                  'assets/icons/left.svg',
                ),
              )
          ),
          border: null,
          middle: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Filter'),
          ),
          trailing: Container(
            margin: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () => {
                onReset()
              },
              child: const Text(
                'Reset',
                style: TextStyle(
                    color: Color.fromRGBO(240, 24, 12, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 17),
              ),
            ),
          ),
        ),
        child: child
    );
  }
}

