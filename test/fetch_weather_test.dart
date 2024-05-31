
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast/domain/weather/use_cases/fetch_weather.dart';
import 'package:weather_forecast/domain/weather/entities/weather.dart';
import 'package:weather_forecast/domain/weather/exceptions/weather_exceptions.dart';

import 'weather_mocks.mocks.dart';

void main() {
  late MockWeatherRepositoryImpl mockWeatherRepository;
  late FetchWeatherUseCase fetchWeatherUseCase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepositoryImpl();
    fetchWeatherUseCase = FetchWeatherUseCase(mockWeatherRepository);
  });

  const testWeather = Weather(
    cityName: 'SomeCity',
    temperature: 30,
    description: 'Sunny',
  );

  test('Fetch', () async {
    when(mockWeatherRepository.fetchWeather(any))
        .thenAnswer((_) async => testWeather);

    final weather = await fetchWeatherUseCase('');

    expect(weather, testWeather);
  });

  test('Fetch From Cache', () async {
    final weatherException = FetchWeatherException();

    when(mockWeatherRepository.fetchWeather(any)).thenThrow(weatherException);
    when(mockWeatherRepository.getCachedWeather(any))
        .thenAnswer((_) async => testWeather);

    final weather = await fetchWeatherUseCase('');

    expect(weather, testWeather);
  });
}
