import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast/domain/weather/use_cases/fetch_weather.dart';
import 'package:weather_forecast/presentation/weather/weather_notifier.dart';
import 'package:weather_forecast/domain/weather/entities/weather.dart';
import 'package:weather_forecast/domain/weather/exceptions/weather_exceptions.dart';

import 'weather_mocks.mocks.dart';

void main() {
  late MockWeatherRepositoryImpl mockWeatherRepository;
  late WeatherNotifier weatherNotifier;
  late FetchWeatherUseCase fetchWeatherUseCase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepositoryImpl();
    fetchWeatherUseCase = FetchWeatherUseCase(mockWeatherRepository);
    weatherNotifier = WeatherNotifier(fetchWeatherUseCase);
  });

  const testWeather = Weather(
    cityName: 'SomeCity',
    temperature: 30,
    description: 'Sunny',
  );

  final initialWeather = Weather.initial();

  test('initial', () {
    expect(weatherNotifier.state, AsyncValue.data(initialWeather));
  });

  test('data', () async {
    when(mockWeatherRepository.fetchWeather(any))
        .thenAnswer((_) async => testWeather);

    await weatherNotifier.fetchWeather('');

    expect(weatherNotifier.state, const AsyncValue.data(testWeather));
  });

  test('error', () async {
    final weatherException = FetchWeatherException();

    when(mockWeatherRepository.fetchWeather(any)).thenThrow(weatherException);
    when(mockWeatherRepository.getCachedWeather(any)).thenThrow(weatherException);

    await weatherNotifier.fetchWeather('');

    expect(weatherNotifier.state, isA<AsyncError>());
    expect(weatherNotifier.state.error, weatherException);
  });
}
