import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:min3_twitwi/common/style.dart';

import 'generated/l10n.dart';




void main() {
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      theme: ThemeData(
        brightness: Brightness.dark,
        buttonColor: Colors.orange,
        iconTheme: IconThemeData(color: Colors.orange[200]),
        primaryIconTheme: IconThemeData(color: Colors.orangeAccent),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: RegularFont
      ),

      home: HomeScreen(),
    );
  }
}



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("aaaaaaaaa"),
      ),
    );
  }
}