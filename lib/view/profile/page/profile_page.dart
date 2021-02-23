import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/view/profile/component/profile_detail_part.dart';
import 'package:min3_twitwi/view/profile/component/profile_post_grid_part.dart';
import 'package:min3_twitwi/view/profile/component/profile_setting_part.dart';
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
    profileViewModel.setProfileUser(profileMode, selectedUser);   /// [セットする]
    /// [Future逃がす]
    Future(  () => profileViewModel.getPost()  );


    return Scaffold(
      body: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          print("comm270: ProfilePage: ${viewModel.posts}");
          final profileUser = viewModel.profileUser;
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(profileUser.inAppUserName),
                ),
                pinned: true,
                floating: true,

                actions: <Widget>[
                  ProfileSettingPart(
                    mode: profileMode,   /// [mode場合分け渡す]
                  ),
                ],
                expandedHeight: 280.0,

                flexibleSpace: FlexibleSpaceBar(
                  background: ProfileDetailPart(
                    mode: profileMode,   /// [mode場合分け渡す]
                  ),
                ),
              ),


              ProfilePostGridPart(
                // posts: profileViewModel.posts,
                posts: viewModel.posts,
              ),
            ],
          );
        },
      ),
    );
  }
}
