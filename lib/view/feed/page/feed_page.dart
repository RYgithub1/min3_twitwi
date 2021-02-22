import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/style.dart';
import 'package:min3_twitwi/view/feed/page/feed_sub_page.dart';
import 'package:min3_twitwi/view/post/screen/post_upload_screen.dart';




class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.cameraRetro),
          onPressed: () => _launchCamera(context),
        ),
        title: Text(
          S.of(context).appTitle,
          style: TextStyle(fontFamily: TitleFont),
        ),
      ),
      body: FeedSubPage(
        feedMode: FeedMode.FROM_FEED,
        index: 0,
      ),
    );
  }



  _launchCamera(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => PostUploadScreen(uploadType: UploadType.CAMERA),
    ));
  }
}