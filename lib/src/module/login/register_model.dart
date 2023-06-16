class RegisterModel {
  String? email;
  String? mobile;
  String? password;
  String? rePassword;
  RegisterModel({this.email, this.password,this.rePassword,this.mobile});

  factory RegisterModel.fromJson(Map<String, dynamic> json,
      {String? email, String? password, String? rePassword,String? mobile}) {
    return RegisterModel(
      email: json['email'],
      mobile: json['mobile'],
      password: json['password'],
      rePassword: json['rePassword'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'mobile': mobile,
      'password': password,
      'rePassword': rePassword,
    };
  }

}