import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/domain/entities/city.dart';
import 'package:flutter_weather/domain/repositories/city.dart';
import 'package:flutter_weather/presentation/models/location.dart';
import 'package:flutter_weather/service_locator.dart';

const Duration _debounceDuration = Duration(milliseconds: 300);

final AutoDisposeFutureProviderFamily<List<Location>, String>
    locationsProvider = FutureProvider.autoDispose.family(
  (Ref ref, String query) async {
    bool isDisposed = false;
    ref.onDispose(() => isDisposed = true);

    await Future<void>.delayed(_debounceDuration);
    if (isDisposed) {
      throw Exception();
    }

    return sl<CityRepository>().getCities(query).then(
        (List<City> v) => v.map((City e) => Location.fromCity(e)).toList());
  },
);

final StateProvider<Location?> selectedLocationProvider =
    StateProvider<Location?>((_) => null);
