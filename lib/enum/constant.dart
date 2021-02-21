/// [post] : uploaad
enum UploadType {
  GALLERY,
  CAMERA,
}


/// [post] : caption
enum PostCaptionOpenMode {
  FROM_POST,
  FROM_FEED,
}


/// [feed] ,,, feed画面デザイン: 共通利用
enum FeedMode {
  FROM_FEED,     // 全体feed: currentUser + followingUser
  FROM_PROFILE,  // 個人feed: profile画面から,対象の人のみ
}


enum PostMenu {
  EDIT,
  DELETE,
  SHARE,
}



/// [profile] :
enum ProfileMode {
  MYSELF,
  OTHER,
}
