import 'package:flutter/material.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/style.dart';
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
            );
          },
        ),
      ],
    );
  }



  _userRecordWidget({BuildContext context, int score, String title}) {
    return Expanded(
      flex: 1,
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
    );
  }


}



