import 'package:localstorage/localstorage.dart';

import '../../shared/basic_respones.dart';
import '../../shared/basic_search.dart';

class OrderSearch extends BasicSearch {
  late String name;
  late String status;
  OrderSearch() {
    page.orderBy = 'ASC';
    page.sortBy = 'productName';
    name = '';
    status = '';
  }
  @override
  fromResponse(BasicResponse response) {
    page.offset = response.number ?? 0;
    page.limit = response.size ?? 0;
    page.last = response.last ?? false;
    page.totalPages = response.totalPages ?? 0;
  }

  @override
  Map<String, dynamic> toJson() {

      return {
        "name": name,
        "status":status,
        "page": {
          "offset": page.offset,
          "limit": page.limit,
          "sortBy": page.sortBy,
          "orderBy": page.orderBy
        }
      };

  }

  clearPaginate() {
    page = BasicPaginate();
  }
}
