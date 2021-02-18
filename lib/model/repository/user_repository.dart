import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/model/database/database_manager.dart';




class UserRepository {
  final DatabaseManager databaseManager;
  UserRepository({this.databaseManager});



  /// [認証,Rで呼ぶ: ログイン有無: AuthentiにcurrentUserが存在する=ログイン中]
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// [アプリ全体で,取得したcurrentUserを使いまわしたい: static]
  static User currentUser;



  Future<bool> isSignIn() async {
    /// final firebaseUser = await _auth.currentUser; [error]
    final firebaseUser = _auth.currentUser;
    /// [存在有＝対象がいる: true]
    if (firebaseUser != null) {
      /// [ログイン記録を保持しておく]
      currentUser = await databaseManager.getUserInfoFromDbById(firebaseUser.uid);

      return true;
    }
    return false;
  }


  Future<bool> signIn() async {
    /// [ggSignIn 可否をtryCatchFinallyで補足]
    try {
      /// [ログイン、認証]
      GoogleSignInAccount signInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication signInAuthentication = await signInAccount.authentication;
      /// [対象token取得]
      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken,
      );

      /// [credential信用状作成]
      final _signInWithCredential = await _auth.signInWithCredential(credential);
      /// [ユーザーnullならfalse]
      final firebaseUser = _signInWithCredential.user;
      // if (firebaseUser != null) return false;
      // 挙動: tryに入っている-> comm003 -> ここで正常にreturn
      if (firebaseUser == null) return false;

      /// [nullではない。実際DBにユーザいるか]
      final isUserExistedInDb = await databaseManager.searchUserInDb(firebaseUser);
      /// [userクラスに変換convert withDDC,,,DBへ登録]
      if (!isUserExistedInDb) {
        await databaseManager.insertUser( _convertToUser(firebaseUser) );
      }

      /// [取得したcurrentUserデータを使い回す]
      currentUser = await databaseManager.getUserInfoFromDbById(firebaseUser.uid); /// [uid == user id]

      print("comm001: UserRepository/signIn: try: true");
      return true;
    } catch(err) {
      print("comm002: UserRepository/signIn: try: false: $err");
      return false;
    } finally {
      print("comm003: UserRepository/signIn: finally");
    }
  }



  /// [DDC: convert-> 初期値代入]
  _convertToUser(auth.User firebaseUser) {
    return User(
      userId: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      inAppUserName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      email: firebaseUser.email,
      bio: "",
    );
  }

  Future<User> getUserById(String userId) async {
    return await databaseManager.getUserInfoFromDbById(userId);
  }




}