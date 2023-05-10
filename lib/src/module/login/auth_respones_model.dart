class AuthResponseModel {
  int? userId;
  String? token;
  AuthResponseModel({ this.userId, this.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json,
      {String? username, String? password}) {
    return AuthResponseModel(
      userId: int.parse(json['userId']),
      token: json['token'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'token': token,
    };
  }


}