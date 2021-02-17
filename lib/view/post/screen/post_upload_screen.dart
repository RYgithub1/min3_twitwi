import 'package:flutter/material.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/post/component/post_caption_part.dart';
import 'package:min3_twitwi/view/post/component/post_location_part.dart';
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

    return Consumer<PostViewModel>(
      builder: (context, viewmodel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: viewmodel.isProcessing
                ? Container()
                : IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => _cancelPost(context),
                ),
            title: viewmodel.isProcessing
                ? Text(S.of(context).underProcessing)
                : Text(S.of(context).post),
            actions: <Widget>[
              (viewmodel.isProcessing || !viewmodel.isImagePicked)
                  ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => _cancelPost(context),
                  )
                  : IconButton(
                    icon: Icon(Icons.done),
                    onPressed: null,
                  )
            ],
          ),

          body: viewmodel.isProcessing
              ? Center(
                child: CircularProgressIndicator()
              )
              : viewmodel.isImagePicked
                  ? Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 40),
                        Divider(),
                        PostCaptionPart(postCaptionOpenMode: PostCaptionOpenMode.FROM_POST),
                        Divider(),
                        SizedBox(height: 40),
                        Divider(),
                        PostLocationPart(),
                        Divider(),
                      ],
                    ),
                  )
                  : Container(),
        );
      },
    );
  }



  void _cancelPost(BuildContext context) {


    Navigator.pop(context);
  }



}