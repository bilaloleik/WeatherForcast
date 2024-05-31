import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_forecast/domain/weather/entities/weather.dart';
import 'package:weather_forecast/data/weather/repositories/weather_repository_impl.dart';
import 'package:weather_forecast/data/weather/services/weather_service.dart';
import 'package:weather_forecast/data/weather/services/weather_cache_service.dart';
import 'package:weather_forecast/domain/weather/repositories/weather_repository.dart';
import 'package:weather_forecast/domain/weather/use_cases/fetch_weather.dart';

class WeatherNotifier extends StateNotifier<AsyncValue<Weather>> {
  final FetchWeatherUseCase _fetchWeatherUseCase;

  WeatherNotifier(this._fetchWeatherUseCase)
      : super(
          AsyncValue.data(
            Weather.initial(),
          ),
        );

  Future<void> fetchWeather(String city) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _fetchWeatherUseCase(city);
      state = AsyncValue.data(weather);
    } catch (e) {
      state = AsyncValue<Weather>.error(e, StackTrace.current);
    }
  }
}

final weatherProvider =
    StateNotifierProvider<WeatherNotifier, AsyncValue<Weather>>((ref) {
  final fetchWeatherUseCase = ref.watch(fetchWeatherUseCaseProvider);
  return WeatherNotifier(fetchWeatherUseCase);
});

final fetchWeatherUseCaseProvider = Provider<FetchWeatherUseCase>((ref){
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  return FetchWeatherUseCase(weatherRepository);
});

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final weatherService = ref.watch(weatherServiceProvider);
  final weatherCacheService = ref.watch(weatherCacheServiceProvider);
  return WeatherRepositoryImpl(weatherService, weatherCacheService);
});

final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService();
});

final weatherCacheServiceProvider = Provider<WeatherCacheService>((ref) {
  return WeatherCacheService();
});
