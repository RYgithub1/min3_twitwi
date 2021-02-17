import 'dart:io';

import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/location.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/model/repository/post_repository.dart';
import 'package:min3_twitwi/model/repository/user_repository.dart';




class PostViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  PostViewModel({this.userRepository, this.postRepository});



  bool isImagePicked = false;
  bool isProcessing = false;   /// [isLoding的]

  File imageFile;

  Location location;
  String locationString = "";  /// [１つの繋がった文字列として表示したいだけ]

  String caption = "";



  Future<void> pickImage(UploadType uploadType) async {
    isImagePicked = false;
    isProcessing = true;
    notifyListeners();

    imageFile = await postRepository.pickImage(uploadType);
    print("comm011: pickImage: imageFile.path: ${imageFile.path}");

    /// [post時にlocationの取得]
    location = await postRepository.getCurrentLocation();
    locationString = _toLocationString(location);
    print("comm012: pickImage: locationString: $locationString");


    if (imageFile != null) isImagePicked = true;
    isProcessing = false;
    notifyListeners();



  }



  String _toLocationString(Location location) {
    return location.country + " " + location.state + " " + location.city;
  }



}