class AddressModel {
  int userId;
  String countryCode;
  String provinceCode;
  String districtCode;
  String subDistrictCode;
  String phoneNumber;
  String address;
  String? countryName;
  String? provinceName;
  String? districtName;
  String? subDistrictName;
  String? postCode;
  AddressModel(
      {required this.userId,
      required this.countryCode,
      required this.provinceCode,
      required this.districtCode,
      required this.subDistrictCode,
      required this.phoneNumber, required this.address,
        this.countryName,
        this.provinceName,
        this.districtName,
        this.subDistrictName,
        this.postCode
      });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      userId: int.parse(json['userId']) ,
      countryCode: json['countryCode'],
      provinceCode: json['provinceCode'],
      districtCode: json['districtCode'],
      subDistrictCode: json['subDistrictCode'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
        countryName:json['country']?['name'],
         provinceName:json['province']?['name'],
         districtName:json['district']?['name'],
        subDistrictName:json['subDistrict']?['name'],
        postCode:json['subDistrict']?['postCode']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'countryCode': countryCode,
      'provinceCode': provinceCode,
      'districtCode': districtCode,
      'subDistrictCode': subDistrictCode,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
