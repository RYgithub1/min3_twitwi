import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/comment.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/comment_rich_text.dart';
import 'package:min3_twitwi/view/common/functions.dart';
import 'package:min3_twitwi/view/common/style.dart';
import 'package:min3_twitwi/view/feed/screen/comment_screen.dart';
import 'package:min3_twitwi/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';




class FeedPostCommentPart extends StatelessWidget {
  final Post post;
  final User postUser;
  FeedPostCommentPart({@required this.post, @required this.postUser});


  @override
  Widget build(BuildContext context) {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);  /// [listen:false]


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
            splashColor: Colors.cyan,
            onTap: () => _openComentScreen(context, post, postUser),   /// [押したらCommentScreen開く]
            // child: Text(
            //   "0 ${S.of(context).comments}",
            //   style: numberOfCommentTextStyle,
            // ),
            /// [無限ループ: FutureBuilder()]
            child: FutureBuilder(
              future: feedViewModel.getComment(post.postId) ,
              builder: (context, AsyncSnapshot<List<Comment>> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final comments = snapshot.data;
                  return Text(
                    comments.length.toString() + "  " + "${S.of(context).comments}",
                    style: numberOfCommentTextStyle,
                  );
                } else {
                  return Container();
                }
              },
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



  _openComentScreen(BuildContext context, Post post, User postUser) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => CommentScreen(
        post: post,
        postUser: postUser,
      ),
    ));
  }

}



