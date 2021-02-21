import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/view/profile/page/profile_page.dart';




class ProfileScreen extends StatelessWidget {
  final ProfileMode profileMode;
  final User selectedUser;
  ProfileScreen({@required this.profileMode, @required this.selectedUser});


  @override
  Widget build(BuildContext context) {
    return ProfilePage(
      profileMode: profileMode,
      selectedUser: selectedUser,
    );
  }
}