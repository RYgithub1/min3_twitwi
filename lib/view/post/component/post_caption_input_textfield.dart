import 'package:flutter/material.dart';
import 'package:min3_twitwi/common/style.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';




class PostCaptionInputTextField extends StatefulWidget {
  PostCaptionInputTextField({Key key}) : super(key: key);
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
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    /// [input内容 -> viewModelに格納]
    postViewModel.caption = _captionTextEditingController.text;
    // print("comm120: _onCaptionUpdated(): ${postViewModel.caption}");
    print("comm120: _onCaptionUpdated()");
  }
}