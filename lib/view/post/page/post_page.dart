import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_twitwi/common/button_with_icon.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/post/screen/post_upload_screen.dart';




class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,   /// [横幅]
            children: <Widget>[
              ButtonWithIcon(
                onPressed: () => _openPostUploadScreen(context, UploadType.GALLERY),
                iconData: FontAwesomeIcons.images,
                label: S.of(context).gallery,
              ),
              SizedBox(height: 40),
              ButtonWithIcon(
                onPressed: () => _openPostUploadScreen(context, UploadType.CAMERA),
                iconData: FontAwesomeIcons.camera,
                label: S.of(context).camera,
              ),
            ],
          ),
        ),
      ),
    );
  }




  _openPostUploadScreen(BuildContext context, UploadType uploadType) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => PostUploadScreen(
        uploadType: uploadType,
      ),
    ));
  }
}