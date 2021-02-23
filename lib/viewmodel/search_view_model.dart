import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/model/repository/user_repository.dart';




class SearchViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  SearchViewModel({this.userRepository});



  List<User> soughtUsers = List();



  Future<void> searchUser(String query) async {
    soughtUsers = await userRepository.searchUser(query);
  }



}