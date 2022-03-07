import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({required this.url});
  final String url;

  Future getData() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
      // String cityName = data['name'];
      // double temp = data['main']['temp'];
      // String description = data['weather'][0]['description'];
      // print("temp: $temp $cityName $description");
    } else {
      print(response.statusCode);
    }
  }
}
