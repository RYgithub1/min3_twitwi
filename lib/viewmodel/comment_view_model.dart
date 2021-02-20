import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/comment.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/model/repository/post_repository.dart';
import 'package:min3_twitwi/model/repository/user_repository.dart';




class CommentViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  CommentViewModel({this.userRepository, this.postRepository});



  /// [getterでcurrentUser準備]
  User get currentUser => UserRepository.currentUser;

  String comment = "";

  List<Comment> comments = List();
  bool isLoading = false;



  Future<void> postComment(Post post) async {
    /// [currentUserは前にgetter/commentはプロパティ定義済み使える。postは呼んでくる]
    await postRepository.postComment(post, currentUser, comment);
    // notifyListeners();
    /// [postした時に最新コメントも欲しい: 間にmethod走らせる]
    /// [delete後にpostの更新]
    getComment(post.postId);
    notifyListeners();
  }



  Future<void> getComment(String postId) async {
    isLoading = true;
    notifyListeners();

    comments = await postRepository.getComment(postId);
    print("comm210: CommentViewModel: getComment: comments from DB: $comments");
    isLoading = false;
    notifyListeners();
  }



  /// [FutureBuilder()ゆえ,,,XxxReturen]
  Future<User> getCommentUserInfo(String commentUserId) async {
    return await userRepository.getUserById(commentUserId);
  }



  Future<void> deleteComment(Post post, int commentIndex) async {
    final deleteCommentId = comments[commentIndex].commentId;   /// [上位で格納されているcomments]
    await postRepository.deleteComment(deleteCommentId);

    /// [delete後にpostの更新]
    getComment(post.postId);
    notifyListeners();
  }




}