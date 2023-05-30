
import 'dart:ui';

import '../../message/models/answer_model.dart';

class CommentModel  {
  String comment;
  double? rating;
  UserModel  commentor;


  CommentModel({
    required this.comment,
    required this.rating,
    required this.commentor,
  });

  factory CommentModel.fromJson(dynamic json) {
    return CommentModel(
        comment: json['comment'],
        rating:  double.parse( json['rating']??0.0),
        commentor: UserModel.fromJson(json['commentor'])
    );

  }
}
