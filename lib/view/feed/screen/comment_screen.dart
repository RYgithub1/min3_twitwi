import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/confirm_dialog.dart';
import 'package:min3_twitwi/view/feed/component/comment_display_part.dart';
import 'package:min3_twitwi/view/feed/component/comment_input_part.dart';
import 'package:min3_twitwi/viewmodel/comment_view_model.dart';
import 'package:provider/provider.dart';




class CommentScreen extends StatelessWidget {
  final Post post;   /// [captionが欲しいので]
  final User postUser;   /// [userデータが欲しいので]
  CommentScreen({@required this.post, @required this.postUser});


  @override
  Widget build(BuildContext context) {

    final commentViewModel =  Provider.of<CommentViewModel>(context, listen: false); /// [Futureで逃がす為]
    Future(  () => commentViewModel.getComment(post.postId)  );    /// [Futureで逃がす]


    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).comments),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /// [----- CAPTION -----]
              CommentDisplayPart(
                postUserPhotoUrl: postUser.photoUrl,
                name: postUser.inAppUserName,
                text: post.caption,
                postDateTime: post.postDateTime,
              ),
              /// [----- COMMENT LIST -----]
              Consumer<CommentViewModel>(
                builder: (context, viewModel, child) {
                  return ListView.builder(
                    shrinkWrap: true,      /// [vertica error]
                    itemCount: viewModel.comments.length,
                    itemBuilder: (context, index) {
                      final comment = viewModel.comments[index];
                      final commentUserId = comment.commentUserId;
                      // return ListTile(
                      //   title: Text(comment.commentUserId),
                      //   subtitle: Text(comment.comment),
                      // );
                      return FutureBuilder(
                        future: viewModel.getCommentUserInfo(commentUserId),
                        builder: (context, AsyncSnapshot<User> snapshot) {
                          if (snapshot.hasData) {
                            final commentUser = snapshot.data;
                            return CommentDisplayPart(
                              postUserPhotoUrl: commentUser.photoUrl,
                              name: commentUser.inAppUserName,
                              text: comment.comment,
                              postDateTime: comment.commentDateTime,
                              /// [長押し削除追加]
                              gestureLongPressCallback: () => showConfirmDialog(
                                  context: context,
                                  title: S.of(context).deleteComment,
                                  content: S.of(context).deleteCommentConfirm,
                                  onConfirmed: (isConfirmed){
                                    if(isConfirmed) {
                                      _deleteComment(context, index);
                                    }
                                  },
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    },
                  );
                },
              ),
              /// [----- COMMENT INPUT -----]
              CommentInputPart(post:post),
            ],
          ),
        ),
      ),
    );
  }



  void _deleteComment(BuildContext context, int commentIndex) async {
    final commentViewModel =  Provider.of<CommentViewModel>(context, listen: false);
    await commentViewModel.deleteComment(post, commentIndex);    /// [postは上位で定義]


  }
}