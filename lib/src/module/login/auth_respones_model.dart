class AuthResponseModel {
  int? id;
  String? token;
  AuthResponseModel({ this.id, this.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json,
      {String? username, String? password}) {
    return AuthResponseModel(
      id: json['id'],
      token: json['token'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
    };
  }


}