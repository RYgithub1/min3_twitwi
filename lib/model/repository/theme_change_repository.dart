import 'package:shared_preferences/shared_preferences.dart';



const PREF_KEY = "isDarkMode";



class ThemeChangeRepository {

  static bool isDarkOn = false;



  /// [----- 書き込み -----]
  // void setTheme(bool isDarkMode) {
  /// [ShatePre: 軽いDB: 非同期future]
  Future<void> setTheme(bool dark) async {
    /*
    final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
    Firestore同様、DBをinstanceで指定して呼ぶ。
    ,,,set/getで読み書き
    */
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(PREF_KEY, dark);

    isDarkOn = dark;
  }



  /// [----- 読み込み -----]
  Future<void> getIsDarkMode() async{
    final prefs = await SharedPreferences.getInstance();
    isDarkOn = prefs.getBool(PREF_KEY) ?? true;  /// [値がnullない時true(DarkMode)にする]
  }




}