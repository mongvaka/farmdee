import 'package:localstorage/localstorage.dart';

import '../../shared/basic_respones.dart';
import '../../shared/basic_search.dart';

class HomeSearch extends BasicSearch {
  late String name;
  late int? ownerId;
  HomeSearch() {
    page.orderBy = 'ASC';
    page.sortBy = 'clientName';
    name = '';
    ownerId = 0;
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
    if (name == '') {
      return {
        "name": '',
        "ownerId": ownerId,
        "page": {
          "offset": page.offset,
          "limit": page.limit,
          "sortBy": page.sortBy,
          "orderBy": page.orderBy
        }
      };
    } else {
      return {
        "name": name,
        "ownerId": ownerId,
        "page": {
          "offset": page.offset,
          "limit": page.limit,
          "sortBy": page.sortBy,
          "orderBy": page.orderBy
        }
      };
    }
  }

  clearPaginate() {
    page = BasicPaginate();
  }
}
