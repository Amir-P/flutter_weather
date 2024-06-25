import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/domain/entities/weather.dart';
import 'package:flutter_weather/presentation/models/location.dart';
import 'package:flutter_weather/presentation/providers/locations.dart';
import 'package:flutter_weather/presentation/providers/weather.dart';

class WeatherDisplay extends ConsumerWidget {
  const WeatherDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Location? location = ref.watch(selectedLocationProvider);
    if (location == null) {
      return const Center(child: Text('Please select a city'));
    }

    final AsyncValue<Weather> weatherValue = ref.watch(weatherProvider);
    return weatherValue.map(
      data: (AsyncData<Weather> data) => WeatherCondition(weather: data.value),
      error: (AsyncError<Weather> error) =>
          Center(child: Text(error.toString())),
      loading: (_) => const Center(child: CircularProgressIndicator()),
    );
  }
}

class WeatherCondition extends StatelessWidget {
  final Weather weather;

  const WeatherCondition({super.key, required this.weather});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(weather.iconUrl),
            Text(weather.description),
            Text('Temp: ${weather.temperature}')
          ],
        ),
      );
}
