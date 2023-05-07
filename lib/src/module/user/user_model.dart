class UserModel  {
  String? lastName;
  String? firstName;
  String email;

  UserModel({
    required this.lastName,
    required this.firstName,
    required this.email
  });

  factory UserModel.fromJson(dynamic json) {
    print(json);
    return UserModel(
      lastName: json['lastName'],
      firstName: json['firstName'],
      email: json['email'] as String,

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