class LoginModel {
  String? username;
  String? password;
  LoginModel({this.username, this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json,
      {String? username, String? password}) {
    return LoginModel(
      username: json['username'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  Map<String, String?> getFromControllerToJson() {
    return {
      'user': username,
      'password': password,
    };
  }
}