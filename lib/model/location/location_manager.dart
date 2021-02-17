import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:min3_twitwi/data/location.dart';




class LocationManager {




  Future<Location> getCurrentLocation() async {
    /// [geolocator: 端末の位置情報取得]
    /// [geocoding : 更に、詳細情報取得]
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    final placemarks = await  geo.placemarkFromCoordinates(position.latitude, position.longitude);
    final placemark = placemarks.first;
    return Future.value(  convert(placemark, position.latitude, position.longitude)  );
  }
  /// [Future不要外す]
  Location convert(geo.Placemark placemark, double latitude, double longitude) {
    return Location(
      latitude: latitude,
      longitude: longitude,
      country: placemark.country,
      state: placemark.administrativeArea,
      city: placemark.locality,
    );
  }



}