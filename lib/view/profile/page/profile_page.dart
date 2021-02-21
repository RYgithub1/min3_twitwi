import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




class ProfilePage extends StatelessWidget {
  final ProfileMode profileMode;
  final User selectedUser;
  ProfilePage({@required this.profileMode, this.selectedUser});


  @override
  Widget build(BuildContext context) {
    /// [--- profile表示: 3経由: BNB, Search, FeedTap ---]
    /// [profileユーザを特定する]
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.setProfileUser(profileMode, selectedUser);
    /// [Future逃がす]
    Future(  () => profileViewModel.getPost()  );


    return Scaffold(
      body: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          print("comm210: ProfilePage: ${viewModel.posts}");
          return Center(
            child: Text("ProfilePage"),
          );
        },
      ),
    );
  }
}