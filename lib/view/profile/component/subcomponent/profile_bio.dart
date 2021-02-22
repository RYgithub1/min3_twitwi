import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/style.dart';
import 'package:min3_twitwi/view/profile/screen/edit_profile_screen.dart';
import 'package:min3_twitwi/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




class ProfileBio extends StatelessWidget {
  final ProfileMode mode;
  ProfileBio({@required this.mode});


  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final profileUser = profileViewModel.profileUser;

    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(profileUser.inAppUserName),
          Text(
            profileUser.bio,
            style: profileBioTitleTextStyle,
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: _button(context, profileUser),
          ),
        ],
      ),
    );
  }



  _button(BuildContext context, User profileUser) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: mode == ProfileMode.MYSELF
          ? Text(S.of(context).editProfile)
          : Text("ssss"),
      onPressed: () => _openEditProfileScreen(context),
    );
  }
  _openEditProfileScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => EditProfileScreen(),
    ));
  }



}