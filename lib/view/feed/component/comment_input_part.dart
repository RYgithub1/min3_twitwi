import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/circle_photo.dart';
import 'package:min3_twitwi/view/common/style.dart';
import 'package:min3_twitwi/viewmodel/comment_view_model.dart';
import 'package:provider/provider.dart';




class CommentInputPart extends StatefulWidget {
  final Post post;
  CommentInputPart({@required this.post});

  @override
  _CommentInputPartState createState() => _CommentInputPartState();
}



class _CommentInputPartState extends State<CommentInputPart> {
  final TextEditingController _commentTextEditingController = TextEditingController();

  bool _isCommentPostEnabled = false;


  @override
  void initState() {
    super.initState();
    _commentTextEditingController.addListener(onComentChanged);
  }
  @override
  void dispose() {
    _commentTextEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    /// [CommentViewModel: getterでcurrentUser準備]
    final commentViewModel = Provider.of<CommentViewModel>(context);
    final _commenter = commentViewModel.currentUser;

    return Card(
      color: Theme.of(context).cardColor,
      child: ListTile(
        leading: CirclePhoto(
          photoUrl: _commenter.photoUrl,
          isImageFromFile: false,   /// [ネットワークから取得ゆえfalse]
        ),
        title: TextField(
          maxLines: null,
          controller: _commentTextEditingController,
          style: commentInputTextStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: S.of(context).addComment,
          ),
        ),
        trailing: FlatButton(
          onPressed: _isCommentPostEnabled   /// [isCommentPostEnabled<bool>してボタン状態条件分け,押せる/色]
              ? () => _postComment(context, widget.post)
              : null,
          child: Text(
            S.of(context).post,
            style: TextStyle(
              color: _isCommentPostEnabled
                  ? Colors.blue
                  : Colors.grey,
            )
          ),
        ),
      ),
    );
  }



  void onComentChanged() {
    final commentViewModel = Provider.of<CommentViewModel>(context, listen: false);
    /// [VM: comment用意して格納]
    commentViewModel.comment = _commentTextEditingController.text;
    print("comm140: onComentChanged: ${commentViewModel.comment}");

    setState(() {
      if (_commentTextEditingController.text.length > 0) {
        _isCommentPostEnabled = true;
      } else {
        _isCommentPostEnabled = false;
      }
    });
  }



  _postComment(BuildContext context, Post post) async {
    final commentViewModel = Provider.of<CommentViewModel>(context, listen: false);
    await commentViewModel.postComment(post);
    _commentTextEditingController.clear();  /// [input後にclear]
  }



}