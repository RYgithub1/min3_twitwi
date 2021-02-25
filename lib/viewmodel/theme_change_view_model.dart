import 'package:flutter/material.dart';
import 'package:min3_twitwi/model/repository/theme_change_repository.dart';
import 'package:min3_twitwi/view/common/style.dart';



class ThemeChangeViewModel extends ChangeNotifier {
  final ThemeChangeRepository themeChangeRepository;
  ThemeChangeViewModel({this.themeChangeRepository});



  /// [ダークモード: 判定2通りゆえbool]
  // bool isDarkMode = true;
  /// [R/static -> インスタンス経由getter]
  bool get isDarkMode => ThemeChangeRepository.isDarkOn;

  /// [getter]
  ThemeData get selectedTheme => isDarkMode
                                    ? darkTheme
                                    : lightTheme;



  void setTheme(bool dark) async {
    await themeChangeRepository.setTheme(dark);
    // isDarkMode = dark;
    notifyListeners();
  }


}