import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:min3_twitwi/data/comment.dart';
import 'package:min3_twitwi/data/like.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/model/repository/user_repository.dart';




class DatabaseManager {


  /// [DB,DatabaseManagerで呼ぶ: ]
  /// [呼び込みauth同様]
  final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;



  Future<bool> searchUserInDb(auth.User firebaseUser) async {
    final query = await _firestoreDb.collection("users")
                                    /// [.where(DBやDDC共通のfield名, 条件)]
                                    /// [uid: userID of firebaseUser]
                                    .where("userId", isEqualTo: firebaseUser.uid)
                                    .get();
    if (query.docs.length > 0) {
      return true;
    } else {
      return false;
    }
  }


  /// [crud: create]
  // Future<void> insertUser(convertToUser) async {
  Future<void> insertUser(User user) async {
    await _firestoreDb.collection("users").doc(user.userId)
                      .set(user.toMap());
  }


  // Future<User> getUserInfoFromDbById(String uid) {}
  Future<User> getUserInfoFromDbById(String userId) async {
    final query = await _firestoreDb.collection("users")
                                    .where("userId", isEqualTo: userId)
                                    .get();
    /// [DDC/fromMap()使える]
    /// [user id 1個のみゆえ0番目取得]
    /// [Map<String, dynamic> data()でデータ取得]
    return User.fromMap(query.docs[0].data());
  }


  Future<String> uploadImageToStorage(File imageFile, String storageId) async {
    final storageRef = FirebaseStorage.instance.ref().child(storageId);
    final uploadTask = storageRef.putFile(imageFile);
    return await uploadTask.then(  (TaskSnapshot snapshot) => snapshot.ref.getDownloadURL()  );
    // return uploadTask.then(  (TaskSnapshot snapshot) => snapshot.ref.getDownloadURL()  );
  }





  Future<void> insertPost(Post post) async {
    await _firestoreDb.collection("posts").doc(post.postId)
                .set(post.toMap());
  }


  Future<List<Post>> getPostsMineAndFollowings(String userId) async {
    /// [Firestoreデータ取得: まずデータ有無の判定]
    final query = await _firestoreDb.collection("posts")
                                    .get();
    if (query.docs.length == 0) return List();

    /// [まずuser]
    /// [自分とフォロー中の2user分必要]
    var userIds = await getFollowingUserIds(userId);
    /// [取得したフォロー中userのidに自分を加える]
    userIds.add(userId);

    /// [次にpost]
    var results = List<Post>();
    await _firestoreDb.collection("posts")
                      .where("userId", whereIn: userIds)
                      .orderBy("postDateTime", descending: true)   // 投稿並べ順: 新しいもの上位
                      .get()
                      .then((value) {   /// [getしたものはList<Snapshot>ゆえ各々] QuerySnapshot
                        value.docs.forEach((element) {
                          results.add(Post.fromMap(element.data()));
                        });
                      });
    print("comm180: getPostsMineAndFollowings: results $results");
    return results;
  }



  Future<List<Post>> getPostsByUser(String userId) async {
    final query = await _firestoreDb.collection("posts")
                                    .get();
    if (query.docs.length == 0) return List();
    var results = List<Post>();
    await _firestoreDb.collection("posts")
                      .where("userId", isEqualTo: userId)
                      .orderBy("postDateTime", descending: true)
                      .get()
                      .then((value) {
                        value.docs.forEach((element) {
                          results.add(Post.fromMap(element.data()));
                        });
                      });
    return results;
  }



  Future<List<String>> getFollowingUserIds(String userId) async {
    final query = await _firestoreDb.collection("users").doc(userId)
                                    .collection("followings")
                                    .get();
    if (query.docs.length == 0 ) return List();
    /// [データ有: follow中userのidを各々取得]
    var userIds = List<String>();
    query.docs.forEach((element) {
      userIds.add(element.data()["userId"]);
    });
    return userIds;
  }


  /// [DB更新]
  Future<void> updatePost(Post updatePost) async {
    final reference = _firestoreDb.collection("posts").doc(updatePost.postId);
    await reference.update(updatePost.toMap());
  }


  Future<void> postComment(Comment comment) async {
    await _firestoreDb.collection("comments").doc(comment.commentId)
                      .set(comment.toMap());
  }


  Future<List<Comment>> getComment(String postId) async {
    final query = await _firestoreDb.collection("comments")
                                    .get();
    if (query.docs.length == 0) return List();
    var results = List<Comment>();
    await _firestoreDb.collection("comments")
                      .where("postId", isEqualTo: postId)
                      .orderBy("commentDateTime")
                      .get()
                      .then((value) {
                        value.docs.forEach((element) {
                          results.add(Comment.fromMap(element.data()));
                        });
                      });
    return results;
  }


  Future<void> deleteComment(String deleteCommentId) async {
    final reference = _firestoreDb.collection("comments").doc(deleteCommentId);
    await reference.delete();
  }


  Future<void> likeIt(Like like) async {
    await _firestoreDb.collection("likes").doc(like.likeId)
                      .set(like.toMap());
  }

  Future<void> unLikeIt(Post post, User currentUser) async {
    final likeRef = await _firestoreDb.collection("likes")
                                      .where("postId", isEqualTo: post.postId)  /// [対象post]
                                      .where("likeUserId", isEqualTo: currentUser.userId)  /// [自分がいいねしたものだけ]
                                      .get();
    /// [上記絞った上でドキュメントid取得,,,中身複数ある]
    likeRef.docs.forEach((element) async {
      final ref = _firestoreDb.collection("likes").doc(element.id);
      /// [ref == ドキュメントid]
      await ref.delete();
    });
  }


  Future<List<Like>> getLikes(String postId) async {
    final query = await _firestoreDb.collection("likes")
                              .get();
    if (query.docs.length == 0) return List();
    var results = List<Like>();
    await _firestoreDb.collection("likes")
                      .where("postId", isEqualTo: postId)
                      .orderBy("likeDateTime")
                      .get()
                      .then((value) {
                        value.docs.forEach((element) {
                          results.add(Like.fromMap(element.data()));
                        });
                      });
    return results;
  }



  Future<void> deletePost(String postId, String imageStoragePath) async {
    /// [----- post -----]
    final postRef = _firestoreDb.collection("posts").doc(postId);  /// [対象ドキュメントをdelete()]
    await postRef.delete();

    /// [----- comment -----]
    final commentRef = await _firestoreDb.collection("comments")
                                        .where("postId", isEqualTo: postId)
                                        .get();
    // 複数あるのでforEach
    commentRef.docs.forEach((element) async {
      final ref = _firestoreDb.collection("comments").doc(element.id);  /// [対象ドキュメントをdelete()]
      await ref.delete();
    });

    /// [----- like -----]
    final likeRef = await _firestoreDb.collection("likes")
                                        .where("postId", isEqualTo: postId)
                                        .get();
    likeRef.docs.forEach((element) async {
      final ref = _firestoreDb.collection("likes").doc(element.id);  /// [対象ドキュメントをdelete()]
      await ref.delete();
    });

    /// [----- storage -----]
    final storageRef = FirebaseStorage.instance.ref().child(imageStoragePath);
    storageRef.delete();
  }




  // Future<List<String>> getNumberOfFollowerUserIds(String userId) async {
  Future<List<String>> getFollowerUserIds(String userId) async {
    /// [いつものDBにデータあるか判定,,,Excert]
    final query = await _firestoreDb.collection("users").doc(userId)
                                    .collection("followers")
                                    .get();
    if (query.docs.length == 0) return List();
    var userIds = List<String>();
    /// [array.docs.forEach]
    query.docs.forEach((element) {
      userIds.add(element.data()["userId"]);
    });
    return userIds;
  }



  Future<void> updateProfile(User updateUser) async {
    /// [updateへ、まず対象のテーブル/レコード -> reference取得]
    final reference = _firestoreDb.collection("users").doc(updateUser.userId);
       /// [updateUser: 丸ごと格納してパス -> toMap()してUPDATE]
    await reference.update(updateUser.toMap());
  }



  /// [duplicate: query <-> queryStringへ変更]
  Future<List<User>> searchUser(String queryString) async {
    final query = await _firestoreDb.collection("users")
                                    .orderBy("inAppUserName")
                                    .startAt([queryString])
                                    .endAt([queryString + "\uf8ff"]) /// [startAt/endAtでワイルドカード検索]
                                    .get();

    if (query.docs.length == 0) return List();

    var soughtUsers = List<User>();
    query.docs.forEach((element) {
      final selectedUsers = User.fromMap(element.data());
      if (selectedUsers.userId != UserRepository.currentUser.userId) {
        soughtUsers.add(selectedUsers);
      }
    });
    return soughtUsers;
  }



  Future<void> follow(User profileUser, User currentUser) async {
    /// [currentUserにとってのfollowings]
    await _firestoreDb.collection("users").doc(currentUser.userId)
                      .collection("followings").doc(profileUser.userId)
                      .set({"userId": profileUser.userId});   /// [map: {}]
    /// [profileUserにとってのfollowers]
    await _firestoreDb.collection("users").doc(profileUser.userId)
                      .collection("followers").doc(currentUser.userId)
                      .set({"userId": currentUser.userId});   /// [map: {}]
  }

  Future<void> unFollow(User profileUser, User currentUser) async {
    /// [currentUserでのfollowingsからの削除]
    await _firestoreDb.collection("users").doc(currentUser.userId)
                      .collection("followings").doc(profileUser.userId)
                      .delete();
    /// [profileUserでのfollowersからの削除]
    await _firestoreDb.collection("users").doc(profileUser.userId)
                      .collection("followers").doc(profileUser.userId)
                      .delete();
  }




  Future<bool> checkIsFollowing(User profileUser, User currentUser) async {
    final query = await _firestoreDb.collection("users").doc(currentUser.userId)
                                    .collection("followings")
                                    .get();
    if (query.docs.length == 0) return false;

    final checkQuery = await _firestoreDb.collection("users").doc(currentUser.userId)
                                          .collection("followings")
                                          .where("userId", isEqualTo: profileUser.userId)
                                          .get();
    if (checkQuery.docs.length > 0) {
      return true;
    } else {
      return false;
    }
  }




  Future<List<User>> getRelatedUserLike(String postId) async {
    final query = await _firestoreDb.collection("likes")
                                    .where("postId", isEqualTo: postId)
                                    .get();
    if (query.docs.length == 0) return List();
    var userIds = List<String>();
    query.docs.forEach((element) {
      userIds.add(element.data()["likeUserId"]);
    });

    /// [上のuserIdのリスト: likeUserId経由、userId取得]
    var likeUsers = List<User>();
    /// [Loop全体をawaitしたい: Future.forEach()]
    await Future.forEach(userIds, (userId) async {
      final user = await getUserInfoFromDbById(userId);
      likeUsers.add(user);
    });
    return likeUsers;
  }


  Future<List<User>> getRelatedUserFollower(String profileUserId) async {
    final followerUserIds = await getFollowerUserIds(profileUserId);
    var followerUsers = List<User>();
    /// [Loop全体をawaitしたい: Future.forEach()]
    await Future.forEach(followerUserIds, (followerUserId) async {
      final user = await getUserInfoFromDbById(followerUserId);
      followerUsers.add(user);
    });
    return followerUsers;
  }

  Future<List<User>> getRelatedUserFollowing(String profileUserId) async {
    final followingUserIds = await getFollowingUserIds(profileUserId);
    var followingUsers = List<User>();
    /// [Loop全体をawaitしたい: Future.forEach()]
    await Future.forEach(followingUserIds, (followingUserId) async {
      final user = await getUserInfoFromDbById(followingUserId);
      followingUsers.add(user);
    });
    return followingUsers;
  }



}