class AddressOptionModel  {
  String code;
  String name;
  String? postCode;
  AddressOptionModel({
    required this.name,
    required this.code,
    this.postCode,
  });

  factory AddressOptionModel.fromJson(dynamic json) {
    return AddressOptionModel(
      name: json['name'],
      code: json['code'],
      postCode: json['postCode'],
    );
  }

}