import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:min3_twitwi/data/comment.dart';
import 'package:min3_twitwi/data/like.dart';
import 'package:min3_twitwi/data/location.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/model/database/database_manager.dart';
import 'package:min3_twitwi/model/location/location_manager.dart';
import 'package:uuid/uuid.dart';




class PostRepository {
  final DatabaseManager databaseManager;
  final LocationManager locationManager;
  PostRepository({this.databaseManager, this.locationManager});




  Future<File> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();
    if (uploadType == UploadType.GALLERY) {
      final gall = await imagePicker.getImage(source: ImageSource.gallery);
      final gallPath = gall.path;
      return File(gallPath);
    } else {
      final came = await imagePicker.getImage(source: ImageSource.camera);
      final camePath = came.path;
      return File(camePath);
    }
  }



  Future<Location> getCurrentLocation() async {
    return await locationManager.getCurrentLocation();
  }


  Future<Location> updateLocation(double latitude, double longitude) async {
    return await locationManager.updateLocation(latitude, longitude);
  }


  /// [=== 投稿 ===]
  Future<void> post(User currentUser, File imageFile, String caption, Location location, String locationString) async {
    /// [画像を(storage)へ保存挿入c/crud,,,post/pgpd -> storageURlから(DB)Firestoreにcreate -> url<StringType>取得]
    final storageId = Uuid().v1();
    final imageUrl = await databaseManager.uploadImageToStorage(imageFile, storageId);

    /// [storageURl -> (DB)Firestore]
    final post =  Post(
      postId: Uuid().v1(),
      userId: currentUser.userId,
      imageUrl: imageUrl,
      imageStoragePath: storageId,
      caption: caption,
      locationString: locationString,
      latitude: location.latitude,
      longitude: location.longitude,
      postDateTime: DateTime.now(),
    );
    await databaseManager.insertPost(post);
  }


  Future<List<Post>> getPosts(FeedMode feedMode, User feedUser) async {
    /// [enum: 場合分け: 取得する投稿posts内容が異なる: if]
    /// [この時点で場合分けされている: feedMode && feedUser]
    if (feedMode == FeedMode.FROM_FEED) {   /// [自分がフォロー中のを取得]
      return databaseManager.getPostsMineAndFollowings(feedUser.userId);
    } else {                                /// [プロフィール画面に表示ユーザのを取得]
      return databaseManager.getPostsByUser(feedUser.userId);
    }
  }


  Future<void> updatePost(Post updatePost) async {
    return databaseManager.updatePost(updatePost);
  }


  Future<void> postComment(Post post, User commentUser, String commentString) async {
    final comment = Comment(
      commentId: Uuid().v1(),
      postId: post.postId,
      commentUserId: commentUser.userId,
      comment: commentString,
      commentDateTime: DateTime.now(),
    );
    await databaseManager.postComment(comment);
  }


  Future<List<Comment>> getComment(String postId) async {
    return databaseManager.getComment(postId);
  }


  Future<void> deleteComment(String deleteCommentId) async {
    await databaseManager.deleteComment(deleteCommentId);
  }




  Future<void> likeIt(Post post, User currentUser) async {
    /// [c/crud: LikeCLASSでの必要事項記入して渡す]
    final like = Like(
      likeId: Uuid().v1(),
      postId: post.postId,
      likeUserId: currentUser.userId,
      likeDateTime: DateTime.now(),
    );
    await databaseManager.likeIt(like);
  }

  Future<void> unLikeIt(Post post, User currentUser) async {
    /// [d/crud: 対象のpostとuser情報]
    await databaseManager.unLikeIt(post, currentUser);
  }


  Future<LikeResult> getLikeResult(String postId, User currentUser) async {
    /// [postに紐づくいいね全てを取得: リスト型]
    final likes = await databaseManager.getLikes(postId);

    /// [そのリスト内、自分がいいねしてたか]
    var isLikedPost = false;
    for (var like in likes) {
      if (like.likeUserId == currentUser.userId) {
        isLikedPost = true;
        break;
      }
    }
    return LikeResult(likes: likes, isLikedToThisPost: isLikedPost);
  }



  Future<void> deletePost(String postId, String imageStoragePath) async {
    await databaseManager.deletePost(postId, imageStoragePath);
  }




}