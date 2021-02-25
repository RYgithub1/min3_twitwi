import 'package:flutter/material.dart';



/// [Theme]
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  buttonColor: Colors.orange,
  iconTheme: IconThemeData(color: Colors.orange[200]),
  primaryIconTheme: IconThemeData(color: Colors.orangeAccent),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: RegularFont,
);
final lightTheme = ThemeData(
  brightness: Brightness.light,
  buttonColor: Colors.lightGreen[100],
  iconTheme: IconThemeData(color: Colors.greenAccent),
  primaryIconTheme: IconThemeData(color: Colors.green),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: RegularFont,

  primaryColor: Colors.greenAccent[100],   /// [baseColor = primary]
);




/// [Font]
const TitleFont = "Billabong";
const RegularFont = "NotoSansJP-Medium";
const BoldFont = "NotoSansJP-Bold";



/// [TextStyle]
// Login
const loginTitleTextStyle = TextStyle(fontFamily: TitleFont, fontSize: 60.0);


// Post
const postCaptionTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 16.0);
const postLocationTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 20.0);


// Feed
const userCardTitleTextStyle = TextStyle(fontFamily: BoldFont, fontSize: 16.0);
const userCardSubTitleTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 12.0);
const numberOfLikeTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 16.0);
const numberOfCommentTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 12.0, color: Colors.grey);
const timeAgoTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 12.0, color: Colors.grey);
const commentNameTextStyle = TextStyle(fontFamily: BoldFont, fontSize: 16.0);
const commentContentTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 12.0);


// Comment
const commentInputTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 20.0);


// Profile
const profileRecordScoreTextStyle = TextStyle(fontFamily: BoldFont, fontSize: 20.0);
const profileRecordTextTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 16.0);
const changeProfilePhotoTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 18.0, color: Colors.orangeAccent);
const editProfileTitleTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 14.0);
const profileBioTitleTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 12.0);


// Search
const searchPageAppbatTitleTextStyle = TextStyle(fontFamily: RegularFont, color: Colors.grey);
