import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/confirm_dialog.dart';
import 'package:min3_twitwi/view/common/user_card.dart';
import 'package:min3_twitwi/view/post/component/post_caption_part.dart';
import 'package:min3_twitwi/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';




class FeedPostEditScreen extends StatelessWidget {
  final User postUser;
  final Post post;
  final FeedMode feedMode;
  FeedPostEditScreen({@required this.postUser, @required this.post, @required this.feedMode});


  @override
  Widget build(BuildContext context) {
    return Consumer<FeedViewModel>(
      builder: (_, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: viewModel.isProcessing
                ? Container()
                : IconButton(
                    icon: Icon(Icons.done),
                    onPressed: () => Navigator.pop(context)
                ),
            title: viewModel.isProcessing
                ? Text(S.of(context).underProcessing)
                : Text(S.of(context).editInfo),
            actions: <Widget>[
              viewModel.isProcessing
                  ? Container()
                  : IconButton(  /// [doneクリック -> Dialog -> updateMethod -> VM update]
                      icon: Icon(Icons.done),
                      onPressed: () => showConfirmDialog(
                        context: context,
                        title: S.of(context).editPost,
                        content: S.of(context).editPostConfirm,
                        onConfirmed: (isConfirmed) {
                          if(isConfirmed) {
                            _updatepost(context);
                          }
                        },
                      ),
                  ),
            ],
          ),
          body: viewModel.isProcessing
              ? Container()
              : SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      UserCard(
                        onTap: null,
                        photoUrl: postUser.photoUrl,
                        title: postUser.inAppUserName,
                        subtitle: post.locationString,
                        // trailing: null,
                      ),
                      PostCaptionPart(
                        postCaptionOpenMode: PostCaptionOpenMode.FROM_FEED,
                        post: post,
                      ),
                    ],
                ),
              ),
        );
      },
    );
  }



  void _updatepost(BuildContext context) async {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    await feedViewModel.updatePost(post, feedMode);
    Navigator.pop(context);
  }



}