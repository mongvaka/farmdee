import '../verify_mobile/model/address_model.dart';

class UserModel  {
  String? lastName;
  String? firstName;
  String email;
  AddressModel? address;

  UserModel({
    required this.lastName,
    required this.firstName,
    required this.email,
    this.address
  });

  factory UserModel.fromJson(dynamic json) {
    print('json');
    print(json);
    return UserModel(
      lastName: json['lastName'],
      firstName: json['firstName'],
      email: json['email'],
      address: AddressModel.fromJson(json['address']?[0]) ,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return
      {
        'lastName': lastName,
        'firstName': firstName,
        'email': email,
      };
  }
}