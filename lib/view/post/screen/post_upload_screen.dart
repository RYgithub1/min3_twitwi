import 'package:flutter/material.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';




class PostUploadScreen extends StatelessWidget {
  final UploadType uploadType;
  PostUploadScreen({@required this.uploadType});


  @override
  Widget build(BuildContext context) {

    final postViewModel =  Provider.of<PostViewModel>(context, listen: false);
    if (!postViewModel.isImagePicked && !postViewModel.isProcessing) {
      /// [画像を取得してきてナイ場合 && 処理中でナイ場合  =>  画像を取得する,,,Futureで逃がす]
      Future(  () => postViewModel.pickImage(uploadType)  );
    }

    return Container(
    );
  }
}