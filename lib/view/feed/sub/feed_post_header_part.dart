import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/confirm_dialog.dart';
import 'package:min3_twitwi/view/common/user_card.dart';
import 'package:min3_twitwi/view/feed/screen/feed_post_edit_screen.dart';
import 'package:min3_twitwi/view/profile/screen/profile_screen.dart';
import 'package:min3_twitwi/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';




class FeedPostHeaderPart extends StatelessWidget {
  final User postUser;
  final Post post;
  final User currentUser;
  /// [FeedModeないので加える]
  final FeedMode feedMode;
  FeedPostHeaderPart({
    @required this.postUser,
    @required this.post,
    @required this.currentUser,
    @required this.feedMode,
  });


  @override
  Widget build(BuildContext context) {
    return UserCard(
        onTap: () => _openProfile(context, postUser),
        photoUrl: postUser.photoUrl,   /// [Need user情報: postUser持ってくる]
        title: postUser.inAppUserName,
        subtitle: post.locationString, /// [location情報表示させたい: postに紐: post持ってくる]
        trailing: PopupMenuButton(   /// [PopupMenuButton]
          icon: Icon(Icons.more_vert),
          onSelected: (value) => _onPopupMenuSelected(context, value),
          itemBuilder: (context) {
            /// [投稿者本人かにより編集権限付与]
            if (postUser.userId == currentUser.userId) {
              return [
                PopupMenuItem(
                  value: PostMenu.EDIT,
                  child: Text(S.of(context).edit),
                ),
                PopupMenuItem(
                  value: PostMenu.DELETE,
                  child: Text(S.of(context).delete),
                ),
                PopupMenuItem(
                  value: PostMenu.SHARE,
                  child: Text(S.of(context).share),
                ),
              ];
            } else {
              return [
                PopupMenuItem(
                  value: PostMenu.SHARE,
                  child: Text(S.of(context).share),
                ),
              ];
            }
          },
        ),
    );
  }



  // _onPopupMenuSelected(BuildContext context, value) {
  _onPopupMenuSelected(BuildContext context, PostMenu selectedMenu) {
    switch(selectedMenu){
      case PostMenu.EDIT:
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => FeedPostEditScreen(
            postUser: postUser,
            post: post,
            feedMode: feedMode,
          ),
        ));
        break;
      case PostMenu.DELETE:
        showConfirmDialog(
          context: context,
          title: S.of(context).deletePost,
          content: S.of(context).deletePostConfirm,
          onConfirmed: (isConfirmed) {
            if(isConfirmed) _deletePost(context, post);
          },
        );
        break;
      case PostMenu.SHARE:
        Share.share(
          post.imageUrl,         /// [コンテンツStringベース]
          subject: post.caption, /// [件名]
        );
        break;
      default:
    }
  }



  void _deletePost(BuildContext context, Post post) async {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    await feedViewModel.deletePost(post, feedMode);  /// [Feed画面開くは経由2パターン: feedMode]
  }



  _openProfile(BuildContext context, User postUser) {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ProfileScreen(
        profileMode: postUser.userId == feedViewModel.currentUser.userId
            ? ProfileMode.MYSELF
            : ProfileMode.OTHER,
        selectedUser: postUser,
      ),
    ));
  }



}