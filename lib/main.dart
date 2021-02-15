import 'package:flutter/material.dart';
import 'package:min3_twitwi/common/style.dart';




void main() {
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
