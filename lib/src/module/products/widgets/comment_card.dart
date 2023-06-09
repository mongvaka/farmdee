import 'package:farmdee/src/widgets/text/caption_text.dart';
import 'package:farmdee/src/widgets/text/detail_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../utils/constants.dart';

class CommentCard extends StatelessWidget {
  final String name;
  final String comment;
  final double rating;
  const CommentCard({Key? key, required this.name, required this.comment, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Row(
            children: [
              DetailText(text: name)
            ],
          ),
          Row(
            children: [
              RatingBar(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                unratedColor: Colors.white,
                ignoreGestures: true,
                itemSize: 16,
                itemPadding:
                EdgeInsets.symmetric(horizontal: 0),
                ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star_rounded,
                    color:STAR_COLOR,
                  ),
                  half: Icon(Icons.star_half_rounded,
                      color: STAR_COLOR),
                  empty: Icon(Icons.star_outline_rounded,
                      color: STAR_COLOR),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ],
          ),

          Row(
            children: [
              CaptionText(text: comment)
            ],
          )
        ],
      ),
    );
  }
}
