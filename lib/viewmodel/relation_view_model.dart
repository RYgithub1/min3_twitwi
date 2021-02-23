import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/model/repository/user_repository.dart';




class RelationViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  RelationViewModel({this.userRepository});



  List<User> relatedUser = List();

  /// [currentUser持っておく]
  User get currentUser => UserRepository.currentUser;



  /// [にがすだけゆえvoid]
  Future<void> getRelatedUser(RelationMode relationMode, String eachId) async {
    relatedUser = await userRepository.getRelatedUser(relationMode, eachId);
    print("comm310: RelationViewModel/getRelatedUser: $relatedUser");
    notifyListeners();
  }



}