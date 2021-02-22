import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/feed/page/feed_sub_page.dart';




class FeedScreen extends StatelessWidget {
  final User feedUser;
  final int index;
  final FeedMode feedMode;
  FeedScreen({     /// [userやidex,mode場合分け欲しい]
    @required this.feedUser,
    @required this.index,
    @required this.feedMode,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).post)),

      body: FeedSubPage(
        feedMode: feedMode,   /// [渡されたmodeをパス]
        /// [user/indexも欲しい]
        feedUser: feedUser,
        index: index,
      ),
    );
  }
}