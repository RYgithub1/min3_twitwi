import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
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



}