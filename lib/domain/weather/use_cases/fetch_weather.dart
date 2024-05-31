import 'package:weather_forecast/domain/weather/entities/weather.dart';
import 'package:weather_forecast/domain/weather/repositories/weather_repository.dart';

class FetchWeatherUseCase {
  FetchWeatherUseCase(this._weatherRepository);
  final WeatherRepository _weatherRepository;

  Future<Weather> call(String city) async {
    try {
      final weather = await _weatherRepository.fetchWeather(city);
      await _weatherRepository.setCachedWeather(city, weather);
      return weather;
    } catch (e) {
      final weather = await _weatherRepository.getCachedWeather(city);
      return weather;
    }
  }
}
