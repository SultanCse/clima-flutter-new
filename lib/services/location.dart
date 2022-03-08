import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;
  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
    print("latitude: $latitude longitude: $longitude");
  }
}
// api key=eca3e85d739a2706e48286ace306f97d
// https://api.openweathermap.org/data/2.5/weather?lat=23.7266214&lon=89.761393&appid=eca3e85d739a2706e48286ace306f97d
