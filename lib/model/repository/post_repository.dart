import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/model/database/database_manager.dart';




class PostRepository {
  final DatabaseManager databaseManager;
  PostRepository({this.databaseManager});




  Future<File> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();
    if (uploadType == UploadType.GALLERY) {
      final gall = await imagePicker.getImage(source: ImageSource.gallery);
      final gallPath = gall.path;
      return File(gallPath);
    } else {
      final came = await imagePicker.getImage(source: ImageSource.camera);
      final camePath = came.path;
      return File(camePath);
    }
  }



}