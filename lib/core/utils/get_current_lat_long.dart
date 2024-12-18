import 'package:geolocator/geolocator.dart';

import 'debug_logger.dart';

class GetCurrentLatLongUtil {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
 static Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Geolocator.openLocationSettings();
      throw "location Is Disabled";
    }
    else {

      permission = await Geolocator.checkPermission();
      debuggerAdvance(tag: "permission", value: permission);

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.deniedForever) {
          Geolocator.openAppSettings();
          throw "locationPermissionDenied";
        }
        debuggerAdvance(tag: "permission after request", value: permission);
        if (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) {
          return await Geolocator.getCurrentPosition();
        }
        throw "locationPermissionDenied";
      }
      else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return await Geolocator.getCurrentPosition();
      }
      else {
        throw "locationPermissionDenied";
      }
    }
  }


}