import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/data/weather/models/weather_model.dart';
import 'package:weather_forecast/domain/weather/exceptions/weather_exceptions.dart';

class WeatherCacheService {
  Future<void> setWeather(String city, WeatherModel weather) async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(city);
    await sp.setString(city, jsonEncode(weather.toJson()));
  }

  Future<WeatherModel> getWeather(String city) async {
    final sp = await SharedPreferences.getInstance();
    final weather = sp.getString(city);
    if (weather != null) {
      return WeatherModel.fromJson(jsonDecode(weather));
    }
    throw FetchWeatherException();
  }
}