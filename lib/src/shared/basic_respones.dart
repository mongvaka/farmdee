class BasicResponse<T> {
  List<T>? content;
  Pageable? pageable;
  int? totalElements;
  int? totalPages;
  bool? last;
  int? size;
  int? number;
  Sort? sort;
  int? numberOfElements;
  bool? first;
  bool? empty;

  BasicResponse({
    this.content,
    this.pageable,
    this.totalElements,
    this.totalPages,
    this.last,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.first,
    this.empty,
  });

  factory BasicResponse.fromJson(Map<String, dynamic> json,Function fromJson) {
    print(json);
    if(json['content']==null){
      return BasicResponse(
          content:  [],
          pageable: Pageable.fromJson(json['pageable']),
          totalElements: json['totalElements'],
          totalPages: json['totalPages'],
          last: json['last'],
          size: json['size'],
          number: json['number'],
          // sort: Sort.fromJson(json['sort']),
          numberOfElements: json['numberOfElements'],
          first: json['first'],
          empty: json['empty']);
    }

    final items = json['content'].cast<Map<String, dynamic>>();
    final results = new List<T>.from(items.map((itemsJson) => fromJson(itemsJson)));
    return BasicResponse(
        content:  results,
        // pageable: Pageable.fromJson(json['pageable']),
        totalElements: json['totalElements'],
        totalPages: json['totalPages'],
        last: json['last'],
        size: json['size'],
        number: json['number'],
        // sort: Sort.fromJson(json['sort']),
        numberOfElements: json['numberOfElements'],
        first: json['first'],
        empty: json['empty']);
  }
}

class Pageable {
  Sort? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  bool? unpaged;
  Pageable(
      {this.sort,
        this.offset,
        this.pageNumber,
        this.pageSize,
        this.paged,
        this.unpaged});
  factory Pageable.fromJson(Map<String, dynamic> json) {
    return Pageable(
        sort: Sort.fromJson(json['sort']),
        offset: json['offset'],
        pageNumber: json['pageNumber'],
        pageSize: json['pageSize'],
        paged: json['paged'],
        unpaged: json['unpaged']);
  }
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;
  Sort({this.empty, this.sorted, this.unsorted});
  factory Sort.fromJson(Map<String, dynamic> json) {
    return Sort(
      empty: json['empty'],
      sorted: json['sorted'],
      unsorted: json['unsorted'],
    );
  }
}
