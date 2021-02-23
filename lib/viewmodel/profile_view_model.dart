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

  /// [followしているか否かbool]
  bool isFollowingProfileUser = false;



  void setProfileUser(ProfileMode profileMode, User selectedUser) {
    if (profileMode == ProfileMode.MYSELF) {
      profileUser = currentUser;
    } else {
      profileUser = selectedUser;

      /// [追加: この段階でフォロー状況のチェック]
      checkIsFollowing();
    }
  }
  /// [追加]
  Future<void> checkIsFollowing() async {
    isFollowingProfileUser = await userRepository.checkIsFollowing(profileUser);
    notifyListeners();
  }




  Future<void> getPost() async {
    isProcessing =true;
    notifyListeners();

    posts = await postRepository.getPosts(FeedMode.FROM_PROFILE, profileUser);
    isProcessing =false;
    notifyListeners();
  }



  Future<void> signOut() async {
    await userRepository.signOut();
    notifyListeners();
  }



  /// [profile: each numbers]
  Future<int> getNumberOfPost() async {
    return (  await postRepository.getPosts(FeedMode.FROM_PROFILE, profileUser)  ).length;
  }
  Future<int> getNumberOfFollower() async {
    return await userRepository.getNumberOfFollower(profileUser);
  }
  Future<int> getNumberOfFollowing() async {
    return await userRepository.getNumberOfFollowing(profileUser);
  }



  Future<String> pickProfileImage() async {
    return (  await postRepository.pickImage(UploadType.GALLERY)  ).path;
  }




  Future<void> updateProfile(
    String photoUrlUpdated,
    bool isImageFromFile,
    String nameUpdated,
    String bioUpdated,
  ) async {
    isProcessing = true;
    notifyListeners();

    await userRepository.updateProfile(
      photoUrlUpdated,
      isImageFromFile,
      nameUpdated,
      bioUpdated,
      profileUser,
    );

    /// [更新の反映: currentUserにデータ持っている]
    /// [UPDATE後ユーザデータの再取得 -> staticへ保存]
    await userRepository.getCurrentUserById(profileUser.userId);
    profileUser = currentUser;
    isProcessing = false;
    notifyListeners();
  }



  Future<void> follow() async {
    await userRepository.follow(profileUser);  /// [対象user: profileUser]
    isFollowingProfileUser = true;
    notifyListeners();
  }
  Future<void> unFollow() async {
    await userRepository.unFollow(profileUser);  /// [対象user: profileUser]
    isFollowingProfileUser = false;
    notifyListeners();
  }





}