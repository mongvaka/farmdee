class RegisterModel {
  String? email;
  String? password;
  String? rePassword;
  RegisterModel({this.email, this.password,this.rePassword});

  factory RegisterModel.fromJson(Map<String, dynamic> json,
      {String? email, String? password, String? rePassword}) {
    return RegisterModel(
      email: json['email'],
      password: json['password'],
      rePassword: json['rePassword'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'rePassword': rePassword,
    };
  }

}