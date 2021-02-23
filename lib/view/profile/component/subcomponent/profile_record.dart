import 'package:flutter/material.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/style.dart';
import 'package:min3_twitwi/view/relation/screen/relation_screen.dart';
import 'package:min3_twitwi/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




class ProfileRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);   /// [参照だけ: false]

    return Row(
      children: <Widget>[
        FutureBuilder(
          future: profileViewModel.getNumberOfPost(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return  _userRecordWidget(
              context: context,
              score: snapshot.hasData
                  ? snapshot.data
                  : 0,
              title: S.of(context).post,
            );
          },
        ),
        FutureBuilder(
          future: profileViewModel.getNumberOfFollower(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return _userRecordWidget(
              context: context,
              score: snapshot.hasData
                  ? snapshot.data
                  : 0,
              title: S.of(context).followers,
              /// [どのmodeからか,,各々のid]
              relationMode: RelationMode.FOLLOWED,
            );
          },
        ),
        FutureBuilder(
          future: profileViewModel.getNumberOfFollowing(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return _userRecordWidget(
              context: context,
              score: snapshot.hasData
                  ? snapshot.data
                  : 0,
              title: S.of(context).followings,
              /// [どのmodeからか,,各々のid]
              relationMode: RelationMode.FOLLOWING,
            );
          },
        ),
      ],
    );
  }



  _userRecordWidget({BuildContext context, int score, String title, RelationMode relationMode}) {
    return Expanded(
      flex: 1,
      /// [どのmodeからか,,各々のid]
      child: GestureDetector(
        onTap: relationMode == null
            ? null  /// [投稿数をタップした場合は処理しない]
            : () => _checkRelationUser(context, relationMode),
        child: Column(
          children: <Widget>[
            Text(
              score.toString(),
              style: profileRecordScoreTextStyle,
            ),
            Text(
              title.toString(),
              style: profileRecordTextTextStyle,
            ),
          ],
        ),
      ),
    );
  }



  _checkRelationUser(BuildContext context, RelationMode _relationMode) {
    final _profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final _profileUser = _profileViewModel.profileUser;
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => RelationScreen(
        relationMode: _relationMode,
        eachId: _profileUser.userId,
      )),
    );
  }




}



