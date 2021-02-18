import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/model/repository/post_repository.dart';
import 'package:min3_twitwi/model/repository/user_repository.dart';




class FeedViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  FeedViewModel({this.userRepository, this.postRepository});



  bool isProcessing = false;
  List<Post> posts = List();

  String caption = "";



  /// [enum: 取得したい投稿異なる: userの情報必要,,,user条件分け]
  User feedUser;
  User get currentUser => UserRepository.currentUser;
  void setFeedUser(FeedMode feedMode, User user) {
    if (feedMode == FeedMode.FROM_FEED) {
      feedUser = currentUser;    /// [ログイン中のuser]
    } else {
      feedUser = user;    /// [profile画面中のuser]
    }
  }


  Future<void> getPosts(FeedMode feedMode) async {
    isProcessing = true;
    notifyListeners();

    posts = await postRepository.getPosts(feedMode, feedUser);
    isProcessing = false;
    notifyListeners();
  }


  Future<User> getPostUserInfo(String userId) async {
    return await userRepository.getUserById(userId);
  }


  Future<void> updatePost(Post post, FeedMode feedMode) async {
    isProcessing = true;

    await postRepository.updatePost(
      /// [POST: copyWithこれが使いたくてDDC: 1部分だけ変更しつつ現行post丸ごと投げれる]
      post.copyWith(caption: caption),
    );

    /// [update後に、表示データも新しく]
    await getPosts(feedMode);
    isProcessing = false;
    notifyListeners();
  }


}