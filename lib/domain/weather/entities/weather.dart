import 'package:equatable/equatable.dart';

class Weather extends Equatable{
  final String description;
  final double temperature;
  final String cityName;

  factory Weather.initial() =>
      const Weather(description: '', temperature: 0, cityName: '');

  const Weather({
    required this.description,
    required this.temperature,
    required this.cityName,
  });

  @override
  List<Object?> get props => [description, temperature, cityName];
}
