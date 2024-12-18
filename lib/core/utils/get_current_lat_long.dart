import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/exceptions_string_constants.dart';
import 'debug_logger.dart';
import 'package:http/http.dart' as http;


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

 static Future<String?> getAddressFromLatLong(double latitude , double longitude) async {
   try {
 //     List<Placemark> addresses = await placemarkFromCoordinates(latitude, longitude);
 // debugPrint("addresses is : ${addresses}");
 //     var first = addresses.first;
 //     debugPrint("${first.name} : ${first..administrativeArea}");
 //     return first.name ?? '';
     const String placesApiKey = "";
     String _host = 'https://maps.google.com/maps/api/geocode/json';
     final url = '$_host?key=$placesApiKey&language=en&latlng=$latitude,$longitude';
     var response = await http.get(Uri.parse(url));
     if (response.statusCode == 200) {
       Map data = jsonDecode(response.body);
       String _formattedAddress = data["results"][0]["formatted_address"];
       print("response ==== $_formattedAddress");
       return _formattedAddress;
     }
     else {
       throw ExceptionStrings.someThingWentWrong;
     }
   }  catch (e) {
     throw ExceptionStrings.someThingWentWrong;
   }
  }


}