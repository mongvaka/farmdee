import 'package:localstorage/localstorage.dart';

import '../../shared/basic_respones.dart';
import '../../shared/basic_search.dart';

class HomeSearch extends BasicSearch {
  late String name;
  HomeSearch() {
    page.orderBy = 'ASC';
    page.sortBy = 'clientName';
    name = '';
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
    final LocalStorage storage = LocalStorage('auth');
    int? id = storage.getItem('id');
    print('this id : $id');
    if (name == '') {
      return {
        "name": '',
        "ownerId": id,
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
