import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_twitwi/data/like.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/style.dart';
import 'package:min3_twitwi/view/feed/screen/comment_screen.dart';
import 'package:min3_twitwi/view/relation/screen/relation_screen.dart';
import 'package:min3_twitwi/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';




class FeedPostLikePart extends StatelessWidget {
  final Post post;   /// [comment渡したいため]
  final User postUser;   /// [userデータ欲しいため]
  FeedPostLikePart({@required this.post, @required this.postUser});


  @override
  Widget build(BuildContext context) {

    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: FutureBuilder(
        /// [何が欲しい?: Like済みかによりV変える: LikeResult]
        future: feedViewModel.getLikeResult(post.postId),
        builder: (context, AsyncSnapshot<LikeResult> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            /// [Futureで返ってきた<LikeResult> dsnapshot.dataを格納してVで使用,,条件分岐]
            final likeResult = snapshot.data;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    /// [== LIKE ==]
                    likeResult.isLikedToThisPost
                        ? IconButton(
                          icon: FaIcon(FontAwesomeIcons.solidHeart),
                          onPressed: () => _unLikeIt(context),
                        )
                        : IconButton(
                          icon: FaIcon(FontAwesomeIcons.heart),
                          onPressed: () => _likeIt(context),
                        ),

                    /// [== COMMENT ==]
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.comment),
                      onPressed: () => _openComentScreen(context, post, postUser),
                    ),
                  ],
                ),
                // Text(
                //   likeResult.likes.length.toString() + "  " + S.of(context).likes,
                //   style: numberOfLikeTextStyle,
                // ),
                /// [押下: Relation]
                GestureDetector(
                  onTap: () => _checkLikeUser(context),
                  child: Text(
                    likeResult.likes.length.toString() + "  " + S.of(context).likes,
                    style: numberOfLikeTextStyle,
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
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




  _likeIt(BuildContext context) async {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    await feedViewModel.likeIt(post);
  }
  _unLikeIt(BuildContext context) async {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    await feedViewModel.unLikeIt(post);
  }




  _checkLikeUser(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => RelationScreen(
        /// [どのmodeからか,,各々のid]
        relationMode: RelationMode.LIKE,
        eachId: post.postId,
      ),
    ));
  }


}