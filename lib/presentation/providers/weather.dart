import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/domain/entities/weather.dart';
import 'package:flutter_weather/domain/repositories/weather.dart';
import 'package:flutter_weather/presentation/models/location.dart';
import 'package:flutter_weather/presentation/providers/locations.dart';
import 'package:flutter_weather/service_locator.dart';

final AutoDisposeFutureProvider<Weather> weatherProvider =
    FutureProvider.autoDispose<Weather>(
  (Ref ref) async {
    final Location selectedLocation = ref.watch(selectedLocationProvider)!;
    return sl<WeatherRepository>().getWeather(selectedLocation.coordinates);
  },
);
