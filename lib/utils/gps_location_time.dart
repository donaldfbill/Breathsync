import 'package:geolocator/geolocator.dart';

class GpsException implements Exception {}

class GpsTime {
  static Future<DateTime> time() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission != LocationPermission.denied) {
        Position position = await Geolocator.getCurrentPosition();
        return position.timestamp;
      }

      final askedPermission = await Geolocator.requestPermission();
      if (askedPermission != LocationPermission.denied) {
        Position position = await Geolocator.getCurrentPosition();
        return position.timestamp;
      }

      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        throw const LocationServiceDisabledException();
      }

      throw GpsException();

    } catch (err) {
      if (err is LocationServiceDisabledException) {
        throw const LocationServiceDisabledException();
      }
      throw GpsException();
    }
  }

  static Future<void> openAppSetting() async {
    await Geolocator.openAppSettings();
  }
}
