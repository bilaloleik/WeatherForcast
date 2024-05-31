import 'package:mockito/annotations.dart';
import 'package:weather_forecast/data/weather/repositories/weather_repository_impl.dart';
import 'package:weather_forecast/data/weather/services/weather_cache_service.dart';
import 'package:weather_forecast/data/weather/services/weather_service.dart';

@GenerateMocks([WeatherRepositoryImpl, WeatherCacheService, WeatherService])
void main() {}