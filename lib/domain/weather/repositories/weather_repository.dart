import 'package:weather_forecast/domain/weather/entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String city);
  Future<Weather> getCachedWeather(String city);
  Future<void> setCachedWeather(String city, Weather weather);
}