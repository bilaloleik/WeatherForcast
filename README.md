# weather_forecast

A Flutter app that displays the weather forecast for a given location.

## Features
- Displays the current weather for a given city.
- Caches previously fetched weather data(used "shared_preferences" package).

## Design
- Clean Architecture.
- State Management: Uses "Riverpod" to handle loading, error & success states.

## Unit Tests
- Uses Mockito package.

## Improvements
- Functional Programming: Use the "dartz" package to handle failures using "Either" wich
  will make the code more predictable.