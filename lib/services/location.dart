import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0;
  double longitude = 0;
  Future getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      print("latitude: $latitude longitude: $longitude");
    } catch (e) {
      print(e);
    }
  }
}
// api key=eca3e85d739a2706e48286ace306f97d
// https://api.openweathermap.org/data/2.5/weather?lat=23.7266214&lon=89.761393&appid=eca3e85d739a2706e48286ace306f97d
