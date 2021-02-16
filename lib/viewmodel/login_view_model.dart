import 'package:flutter/material.dart';
import 'package:min3_twitwi/model/repository/user_repository.dart';




class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  LoginViewModel({this.userRepository});



  bool isLoading = false;
  bool isSuccessful = false;   // 実行成功



  /// [サインイン中判定]
  /// [FutureBoolReturn, NoArgu]
  Future<bool> isSignIn() async {
    return await userRepository.isSignIn();
  }


  /// [サインイン実行]
  Future<void> signIn() async {
    isLoading = true;
    notifyListeners();

    isSuccessful = await userRepository.signIn();
    isLoading = false;
    notifyListeners();
  }


}