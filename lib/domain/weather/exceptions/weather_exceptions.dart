class WeatherErrors{
  static const fetchWeatherError = 'Error loading weather data';
}

class WeatherException implements Exception {
  final String _message;

  WeatherException(this._message);

  @override
  String toString() => _message;
}

class FetchWeatherException extends WeatherException {
  FetchWeatherException() : super(WeatherErrors.fetchWeatherError);
}
