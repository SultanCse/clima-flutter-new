import 'dart:convert';

import 'package:clima_flutter_new/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    Location l = Location();
    l.getCurrentLocation();
    getData();
  }

  Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=23.7266214&lon=89.761393&appid=eca3e85d739a2706e48286ace306f97d');
  void getData() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String cityName = data['name'];
      double temp = data['main']['temp'];
      String description = data['weather'][0]['description'];
      print("$temp $cityName $description");
    } else
      print(response.statusCode);
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Get the current location
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
