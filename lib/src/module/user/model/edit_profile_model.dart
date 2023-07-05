class EditProfileModel {
  String? fName;
  String? lName;
  int? id;
  EditProfileModel({
        required this.fName,
        required this.lName,
        this.id
      });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fName': fName,
      'lName': lName
    };
  }
}