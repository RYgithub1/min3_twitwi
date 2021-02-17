import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:min3_twitwi/data/location.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/model/database/database_manager.dart';
import 'package:min3_twitwi/model/location/location_manager.dart';
import 'package:uuid/uuid.dart';




class PostRepository {
  final DatabaseManager databaseManager;
  final LocationManager locationManager;
  PostRepository({this.databaseManager, this.locationManager});




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



  Future<Location> getCurrentLocation() async {
    return await locationManager.getCurrentLocation();
  }


  Future<Location> updateLocation(double latitude, double longitude) async {
    return await locationManager.updateLocation(latitude, longitude);
  }


  /// [=== 投稿 ===]
  Future<void> post(User currentUser, File imageFile, String caption, Location location, String locationString) async {
    /// [画像を(storage)へ保存挿入c/crud,,,post/pgpd -> storageURlから(DB)Firestoreにcreate -> url<StringType>取得]
    final storageId = Uuid().v1();
    final imageUrl = await databaseManager.uploadImageToStorage(imageFile, storageId);

    /// [storageURl -> (DB)Firestore]
    final post =  Post(
      postId: Uuid().v1(),
      userId: currentUser.userId,
      imageUrl: imageUrl,
      imageStoragePath: storageId,
      caption: caption,
      locationString: locationString,
      latitude: location.latitude,
      longitude: location.longitude,
      postDateTime: DateTime.now(),
    );
    await databaseManager.insertPost(post);


  }



}