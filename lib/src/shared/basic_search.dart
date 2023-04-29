import 'basic_respones.dart';

abstract class BasicSearch {
  late BasicPaginate page = BasicPaginate();
  Map<String, dynamic> toJson();
  fromResponse(BasicResponse response);
}

class BasicPaginate {
  int offset = 0;
  int limit = 10;
  String sortBy = '';
  String orderBy = 'ASC';
  bool last = false;
  int totalPages = 0;
  BasicPaginate();
}

class BasicFilter {
  final String key;
  final String operation;
  final String value;

  BasicFilter(
      {required this.key, required this.operation, required this.value});

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'operation': operation,
      'value': value,
    };
  }
}