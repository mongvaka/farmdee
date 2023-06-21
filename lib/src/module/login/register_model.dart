class RegisterModel {
  String? email;
  String? fName;
  String? lName;
  String? mobile;
  String? password;
  String? rePassword;
  RegisterModel({this.email, this.password,this.rePassword,this.mobile,this.fName,this.lName});

  factory RegisterModel.fromJson(Map<String, dynamic> json,
      {String? email, String? password, String? rePassword,String? mobile}) {
    return RegisterModel(
      email: json['email'],
      mobile: json['mobile'],
      password: json['password'],
      rePassword: json['rePassword'],
      fName: json['fName'],
      lName: json['lName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'mobile': mobile,
      'password': password,
      'rePassword': rePassword,
      'fName': fName,
      'lName': lName,
    };
  }

}