import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/user_card.dart';
import 'package:min3_twitwi/view/profile/screen/profile_screen.dart';
import 'package:min3_twitwi/viewmodel/relation_view_model.dart';
import 'package:provider/provider.dart';




class RelationScreen extends StatelessWidget {
  /// [どのmodeからか,,各々のid(LIKE: postID,,,FOLLOW: userID)]
  final RelationMode relationMode;
  final String eachId;
  RelationScreen({@required this.relationMode, @required this.eachId});


  @override
  Widget build(BuildContext context) {
    final relationViewModel = Provider.of<RelationViewModel>(context, listen: false);
    /// [Futureにがす]
    Future(  () => relationViewModel.getRelatedUser(relationMode, eachId)  );


    return Scaffold(
      appBar: AppBar(
        title: Text(_titleText(context, relationMode)),
      ),
      body: Consumer<RelationViewModel>(
        builder: (_, viewModel, child) {
          return viewModel.relatedUser.isEmpty
              ? Container()
              : ListView.builder(
                itemCount: viewModel.relatedUser.length,
                itemBuilder: (context, int index) {
                  final user = viewModel.relatedUser[index];
                  return UserCard(
                    onTap: () => _openProfileScreen(context, user),
                    photoUrl: user.photoUrl,
                    title: user.inAppUserName,
                    subtitle: user.bio,
                  );
                },
              );
        },
      )
    );
  }



  String _titleText(BuildContext context, RelationMode relationMode) {
    var titelText = "";
    switch (relationMode) {
      case RelationMode.LIKE:
        titelText = S.of(context).likes;
        break;
      case RelationMode.FOLLOWING:
        titelText = S.of(context).followings;
        break;
      case RelationMode.FOLLOWED:
        titelText = S.of(context).followers;
        break;
      default:
    }
    return titelText;
  }



  _openProfileScreen(BuildContext context, User _user) {
    final relationViewModel = Provider.of<RelationViewModel>(context, listen: false);
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => ProfileScreen(
        profileMode: _user.userId == relationViewModel.currentUser.userId
            ? ProfileMode.MYSELF   /// [自分の場合true]
            : ProfileMode.OTHER,   /// [自分でない場合false]
        selectedUser: _user
      ),
    ));
  }



}