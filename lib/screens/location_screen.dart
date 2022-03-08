import 'package:clima_flutter_new/services/weather.dart';
import 'package:clima_flutter_new/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});
  final dynamic weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? cityName;
  double? temp;
  String? description;
  int? iconId;
  updateUI(dynamic data) {
    print(data);
    setState(() {
      if (data != 404) {
        cityName = data['name'];
        temp = data['main']['temp'];
        description = data['weather'][0]['description'];
        iconId = data['weather'][0]['id'];
      } else {
        cityName = "Not Found";
        temp = -0;
        description = "Error occurs in fetching data";
        iconId = 900;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      dynamic data = await WeatherModel().getLocationWeather();
                      updateUI(data);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var receivedCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CityScreen(),
                        ),
                      );
                      if (receivedCityName != null) {
                        var data = await WeatherModel()
                            .getCityWeather(receivedCityName);
                        updateUI(data);
                      }
                      print(receivedCityName);
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temp.toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      WeatherModel().getWeatherIcon(iconId!),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "${WeatherModel().getMessage(temp!)} ${description!}  in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
