import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {

  static Future<Map<String,dynamic>>
      getCurrentLocation() async {

    bool serviceEnabled =
        await Geolocator
            .isLocationServiceEnabled();

    if(!serviceEnabled){
      throw Exception(
        "Location disabled"
      );
    }

    LocationPermission permission =
        await Geolocator
            .checkPermission();

    if(permission ==
        LocationPermission.denied){

      permission=
      await Geolocator
          .requestPermission();
    }

    Position position =
        await Geolocator
            .getCurrentPosition(
      desiredAccuracy:
      LocationAccuracy.high,
    );

    List<Placemark>
        placeMarks=
    await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final place=
        placeMarks.first;

    return {

      "lat":
      position.latitude,

      "lng":
      position.longitude,

      "address":
      "${place.street}, "
      "${place.locality}, "
      "${place.administrativeArea}",

      "city":
      place.locality,

      "state":
      place.administrativeArea,
    };
  }
}