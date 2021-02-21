import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/model/repository/post_repository.dart';
import 'package:min3_twitwi/model/repository/user_repository.dart';




class ProfileViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  ProfileViewModel({this.userRepository, this.postRepository});



  /// [profile表示は誰か]
  User profileUser;
  /// [profile表示は誰か]
  User get currentUser => UserRepository.currentUser;

  bool isProcessing = false;
  List<Post> posts =[];



  void setProfileUser(ProfileMode profileMode, User selectedUser) {
    if (profileMode == ProfileMode.MYSELF) {
      profileUser = currentUser;
    } else {
      profileUser = selectedUser;
    }
  }


  Future<void> getPost() async {
    isProcessing =true;
    notifyListeners();

    posts = await postRepository.getPosts(FeedMode.FROM_PROFILE, profileUser);
    isProcessing =false;
    notifyListeners();


  }



}