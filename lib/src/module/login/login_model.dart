class LoginModel {
  String? email;
  String? password;
  LoginModel({this.email, this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json,
      {String? email, String? password}) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  Map<String, String?> getFromControllerToJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}