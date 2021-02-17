import 'package:flutter/material.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/view/post/component/hero_image.dart';
import 'package:min3_twitwi/view/post/component/post_caption_input_textfield.dart';
import 'package:min3_twitwi/view/post/screen/enlargr_image_screen.dart';
import 'package:min3_twitwi/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';




class PostCaptionPart extends StatelessWidget {
  final PostCaptionOpenMode postCaptionOpenMode;   /// [openパターン2つ受け渡し -> conditional]
  PostCaptionPart({@required this.postCaptionOpenMode});


  @override
  Widget build(BuildContext context) {

    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    final _image = Image.file(postViewModel.imageFile);

    if (postCaptionOpenMode == PostCaptionOpenMode.FROM_POST) {
      return ListTile(
        leading: HeroImage(
          /// [PostViewModelが持つimageファイルが欲しい]
          image: _image,
          onTap: () => _displayLargeImage(context, _image),
        ),
        title: PostCaptionInputTextField(),
      );
    } else {
      return Container();
    }
  }



  _displayLargeImage(BuildContext context, Image image) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => EnlargrImageScreen(image: image),
    ));
  }



}