import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';




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


  Future<List<Post>> getPostsByUser(String userId) {
    return null;

  }




  Future<List<String>> getFollowingUserIds(String userId) async {
    final query = await _firestoreDb.collection("users").doc(userId)
                                    .collection("followings")
                                    .get();
    if (query.docs.length > 0 ) return List();
    /// [データ有: follow中userのidを各々取得]
    var userIds = List<String>();
    query.docs.forEach((element) {
      userIds.add(element.data()["userId"]);
    });
    return userIds;
  }


  /// [DB更新]
  Future<void> updatePost(Post updatePost) async {
    final reference = await _firestoreDb.collection("posts").doc(updatePost.postId);
    await reference.update(updatePost.toMap());

  }



}