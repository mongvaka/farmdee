import 'package:localstorage/localstorage.dart';

import '../../shared/basic_respones.dart';
import '../../shared/basic_search.dart';

class MessageSearch extends BasicSearch {
  late String message;
  late int clientId;
  MessageSearch() {
    page.orderBy = 'ASC';
    page.sortBy = 'createDate';
    message = '';
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
    int? ownerId =  storage.getItem('id');
    clientId = ownerId!;
    if (message == '') {
      return {
        "clientId":clientId,
        "message": '',
        "page": {
          "offset": page.offset,
          "limit": page.limit,
          "sortBy": page.sortBy,
          "orderBy": page.orderBy
        }
      };
    } else {
      return {
        "clientId":clientId,
        "message": message,
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
