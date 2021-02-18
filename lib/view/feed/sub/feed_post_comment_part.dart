import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/comment_rich_text.dart';
import 'package:min3_twitwi/view/common/functions.dart';
import 'package:min3_twitwi/view/common/style.dart';




class FeedPostCommentPart extends StatelessWidget {
  final Post post;
  final User postUser;
  FeedPostCommentPart({@required this.post, @required this.postUser});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// [投稿者名とキャプション]
          CommentRichText(
            name: postUser.inAppUserName,   /// [appのnameと,captionが要る]
            text: post.caption,
          ),
          InkWell(
            // splachColor: ,
            onTap: null,
            child: Text(
              "0 ${S.of(context).comments}",
              style: numberOfCommentTextStyle,
            ),
          ),
          Text(
            // "0 時間前",
            createTimeAgoString(post.postDateTime),
            style: timeAgoTextStyle,
          )
        ],
      ),
    );
  }
}