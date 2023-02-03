import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_forecast/data/album_model.dart';

class WeatherProvider {
  static String _apiKey = "3cfcedc42daa81b2baa16347828b5e38";

  static Future<WeatherModel> fetchCurrentWeather({
    String lat = "47.215784094857284",
    String lon = "38.91267734755913",
  }) async {
    // var uri = Uri.parse(
    //     'http://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&exclude=minutely,hourly,daily,alerts');
    var uri = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=ru');

    final response = await http.post(uri);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<List<WeatherModel>> fetchHourlyWeather({
    String lat = "47.215784094857284",
    String lon = "38.91267734755913",
  }) async {
    var uri = Uri.parse(
        'http://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$_apiKey&units=metric');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<WeatherModel> data =
          (jsonData['list'] as List<dynamic>).map((item) {
        return WeatherModel.fromJson(item);
      }).toList();
      return data;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
