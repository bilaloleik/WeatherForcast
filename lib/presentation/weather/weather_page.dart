import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_forecast/presentation/text_styles.dart';
import 'package:weather_forecast/presentation/weather/weather_notifier.dart';

class WeatherPage extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Weather Forecast')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final notifier = ref.read(weatherProvider.notifier);
                    notifier.fetchWeather(_controller.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            weatherState.when(
              data: (weather) => Column(
                children: [
                  Text(
                    weather.cityName,
                    style: WeatherTextStyles.large,
                  ),
                  Text(
                    '${weather.temperature}°C',
                    style: WeatherTextStyles.medium,
                  ),
                  Text(
                    weather.description,
                    style: WeatherTextStyles.small,
                  ),
                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text(error.toString()),
            ),
          ],
        ),
      ),
    );
  }
}