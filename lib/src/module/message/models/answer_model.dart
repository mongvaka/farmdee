
class AnswerModel  {
  int id;
  String? email;
  String? firstName;
  String? lastName;

  AnswerModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName
  });

  factory AnswerModel.fromJson(dynamic json) {
    print('json');
    print(json);
    return AnswerModel(
      id: int.parse(json['id'])  ,
      email: json['email'] as String,
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return
      {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
      };
  }
}
