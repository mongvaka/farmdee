
class SearchHardwareModel  {
  String key;
  int? ownerId;
  OwnerModel? owner;

  SearchHardwareModel({
    required this.key,
     this.ownerId,
     this.owner,
  });

  factory SearchHardwareModel.fromJson(dynamic json) {
    return SearchHardwareModel(
      key: json['key'] as String,
      ownerId: int.parse(json['ownerId']??'0' ) ,
      owner:json['owner']==null?null: OwnerModel.fromJson(json['owner']),
    );
  }
}
class OwnerModel{
  String? firstName;
  String? lastName;
  String? email;

  OwnerModel({ this.firstName, this.lastName, this.email});
  factory OwnerModel.fromJson(dynamic json){
    return OwnerModel(
      firstName:  json['firstName'],
      lastName:  json['lastName'],
      email:  json['email'],
    );
  }
}
