import 'package:weather_forecast/domain/weather/entities/weather.dart';
import 'package:weather_forecast/domain/weather/repositories/weather_repository.dart';
import 'package:weather_forecast/data/weather/services/weather_cache_service.dart';
import 'package:weather_forecast/data/weather/services/weather_service.dart';
import 'package:weather_forecast/data/weather/models/weather_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherService _weatherService;
  final WeatherCacheService _weatherCacheService;

  WeatherRepositoryImpl(this._weatherService, this._weatherCacheService);

  @override
  Future<Weather> fetchWeather(String city) async {
    final weather = await _weatherService.fetchWeather(city);
    return weather;
  }

  @override
  Future<Weather> getCachedWeather(String city) async {
    final weather = await _weatherCacheService.getWeather(city);
    return weather;
  }

  @override
  Future<void> setCachedWeather(String city, Weather weather) async {
    final weatherModel = WeatherModel(
      description: weather.description,
      temperature: weather.temperature,
      cityName: weather.cityName,
    );
    return await _weatherCacheService.setWeather(city, weatherModel);
  }
}
