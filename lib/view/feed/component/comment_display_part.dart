import 'package:flutter/material.dart';
import 'package:min3_twitwi/view/common/circle_photo.dart';
import 'package:min3_twitwi/view/common/comment_rich_text.dart';
import 'package:min3_twitwi/view/common/functions.dart';
import 'package:min3_twitwi/view/common/style.dart';




/// [共用comment style]
class CommentDisplayPart extends StatelessWidget {
  final String postUserPhotoUrl;
  final String name;
  final String text;
  final DateTime postDateTime;
  final GestureLongPressCallback gestureLongPressCallback;
  CommentDisplayPart({
    @required this.postUserPhotoUrl,
    @required this.name,
    @required this.text,
    @required this.postDateTime,
    this.gestureLongPressCallback,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.yellow,
        onTap: gestureLongPressCallback,   /// [final定義してこれだけ]

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CirclePhoto(photoUrl: postUserPhotoUrl, isImageFromFile: false),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommentRichText(
                  name: name,
                  text: text,
                ),
                Text(
                  createTimeAgoString(postDateTime),
                  style: timeAgoTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}