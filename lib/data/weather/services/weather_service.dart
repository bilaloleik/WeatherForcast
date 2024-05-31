import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:weather_forecast/data/weather/services/weather_api.dart';
import 'package:weather_forecast/data/weather/models/weather_model.dart';
import 'package:weather_forecast/domain/weather/exceptions/weather_exceptions.dart';

class WeatherService {
  Future<WeatherModel> fetchWeather(String city) async {
    try {
      final response = await get(Uri.parse(
          '${WeatherApi.baseUrl}?q=$city&appid=${WeatherApi.apiKey}'));
      if (response.statusCode == HttpStatus.ok) {
        return WeatherModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw FetchWeatherException();
    }
    throw FetchWeatherException();
  }
}
