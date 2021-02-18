import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/view/feed/sub/feed_post_comment_part.dart';
import 'package:min3_twitwi/view/feed/sub/feed_post_header_part.dart';
import 'package:min3_twitwi/view/feed/sub/feed_post_image_from_url_part.dart';
import 'package:min3_twitwi/view/feed/sub/feed_post_like_part.dart';
import 'package:min3_twitwi/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';




class FeedPostTile extends StatelessWidget {
  final FeedMode feedMode;
  final Post post;
  FeedPostTile({this.feedMode, this.post});


  @override
  Widget build(BuildContext context) {

    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);

    return Padding(  
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: FutureBuilder(   /// [無限ループ: Future, not Consumer],,,[user毎のデータをV]
        future: feedViewModel.getPostUserInfo(post.userId),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final postUser = snapshot.data;
            final currentUser = feedViewModel.currentUser;
            print("comm130: FeedPostTile: postUser: $postUser");
            print("comm131: FeedPostTile: currentUser: $currentUser");
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FeedPostHeaderPart(
                  postUser: postUser,
                  post: post,
                  currentUser: currentUser,
                  feedMode: feedMode,
                ),
                FeedPostImageFromUrlPart(imageUrl: post.imageUrl),
                FeedPostLikePart(),
                FeedPostCommentPart(
                  post: post,
                  postUser: postUser,
                ),
              ],
            );
          } else {
            return Container();
          }
        }
      ),
    );
  }
}