import 'package:flutter/material.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/style.dart';
import 'package:min3_twitwi/viewmodel/feed_view_model.dart';
import 'package:min3_twitwi/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';




class PostCaptionInputTextField extends StatefulWidget {
  final String captionBeforeUpload;   /// [caption編集画面への遷移時に、現行caption見たい]
  final PostCaptionOpenMode postCaptionOpenMode;   /// [Feed/Postどっちから開くか]
  PostCaptionInputTextField({this.captionBeforeUpload, this.postCaptionOpenMode});

  @override
  _PostCaptionInputTextFieldState createState() => _PostCaptionInputTextFieldState();
}




class _PostCaptionInputTextFieldState extends State<PostCaptionInputTextField> {
  final TextEditingController _captionTextEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _captionTextEditingController.addListener(() {   /// [(() { }): VoidCallback]
      _onCaptionUpdated();
    });

    if (widget.postCaptionOpenMode == PostCaptionOpenMode.FROM_FEED) {
      _captionTextEditingController.text = widget.captionBeforeUpload;
    }
  }
  @override
  void dispose() {
    _captionTextEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _captionTextEditingController,
      style: postCaptionTextStyle,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: S.of(context).inputCaption,
        border: InputBorder.none,
      ),
    );
  }


  _onCaptionUpdated() {
    if (widget.postCaptionOpenMode == PostCaptionOpenMode.FROM_FEED) {
        final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
        feedViewModel.caption = _captionTextEditingController.text;
        print("comm120: _onCaptionUpdated(): PostCaptionOpenMode.FROM_FEED");
    } else {
        final postViewModel = Provider.of<PostViewModel>(context, listen: false);
        /// [input内容 -> viewModelに格納]
        postViewModel.caption = _captionTextEditingController.text;
        print("comm121: _onCaptionUpdated(): PostCaptionOpenMode.FROM_POST");
    }
  }
}