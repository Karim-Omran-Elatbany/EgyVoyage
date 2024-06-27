import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<List> getCurrentLocation(currentLat, currentLong) async {
  await requestLocationPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  currentLat = position.latitude;
  currentLong = position.longitude;
  print("current lat:$currentLat");
  print("current long:$currentLong");
  return [currentLat, currentLong];
}

Future<void> requestLocationPermission() async {
  // Request location permission
  PermissionStatus status = await Permission.location.request();
  if (status == PermissionStatus.granted) {
    // Permission granted, continue with your logic here
    print('Location permission granted');
  } else if (status == PermissionStatus.denied) {
    // Permission denied, handle it accordingly
    print('Location permission denied');
  } else {
    // Permission previously denied and permanently denied.
    // You may need to open app settings to enable the permission manually.
    print('Location permission permanently denied');
  }
}
