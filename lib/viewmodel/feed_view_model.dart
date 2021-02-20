import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/comment.dart';
import 'package:min3_twitwi/data/like.dart';
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



  Future<List<Comment>> getComment(String postId) async {
    return await postRepository.getComment(postId);
  }




  Future<void> likeIt(Post post) async {
    await postRepository.likeIt(post, currentUser);   /// [いいねした人のid欲しい: currentUser]
    notifyListeners();
  }

  Future<void> unLikeIt(Post post) async {
    await postRepository.unLikeIt(post, currentUser);
    notifyListeners();
  }

  Future<LikeResult> getLikeResult(String postId) async {
    /// [対象のpost欲しい: postId ,,, 自分がいいねしたか条件分岐: currentUser]
    return await postRepository.getLikeResult(postId, currentUser);
  }




  Future<void> deletePost(Post post, FeedMode feedMode) async {
    isProcessing = true;
    notifyListeners();

    await postRepository.deletePost(post.postId, post.imageStoragePath); /// [紐づくstorage画像も削除: imageStoragePath]
    /// [update後に、表示データも新しく]
    await getPosts(feedMode);
    isProcessing = false;
    notifyListeners();
  }



}