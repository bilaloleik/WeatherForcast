import 'package:weather_forecast/domain/weather/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.description,
    required super.temperature,
    required super.cityName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      cityName: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weather': [
        {'description': description}
      ],
      'main': {
        'temp': temperature,
      },
      'name': cityName,
    };
  }
}
