import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:min3_twitwi/model/repository/theme_change_repository.dart';
import 'package:min3_twitwi/view/home_screen.dart';
import 'package:min3_twitwi/view/login/login_screen.dart';
import 'package:min3_twitwi/viewmodel/login_view_model.dart';
import 'package:min3_twitwi/viewmodel/theme_change_view_model.dart';
import 'package:provider/provider.dart';
import 'dinjection/providers.dart';
import 'generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeAgo;




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  final themeChangeRepository = ThemeChangeRepository();
  await themeChangeRepository.getIsDarkMode();


  timeAgo.setLocaleMessages("ja", timeAgo.JaMessages());

  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    /// [theme動的変更: V変更ある: listen: true]
    final themeChangeViewModel = Provider.of<ThemeChangeViewModel>(context);


    return MaterialApp(
      localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      debugShowCheckedModeBanner: false,
      title: 'TWITWI',


      /// [theme動的変更]
      theme: themeChangeViewModel.selectedTheme,


      // home: HomeScreen(),
      /// [ログイン認証はUserテーブルにcurrentUserいるか否か: FutureBuilder: 非同期処理まってWidget生成]
      /// [Consumer vs FurtureBuilder]
      /// [(1)遷移は可能だがログイン判定,,,Future結果次第でConditionにしたい]
      /// [(2)無限ループを避ける,,,notifyループ]
      home: FutureBuilder(
        future: loginViewModel.isSignIn(),
        builder: (context, AsyncSnapshot<bool> snapshot){
          if (snapshot.hasData && snapshot.data){
            /// [データがあるhasData、かつtrue -> ログイン中ゆえHomeScreen見せる]
            return HomeScreen();
          } else {
            /// [まずログイン処理の実行screenへ]
            return LoginScreen();
          }
        },
      ),
    );
  }
}