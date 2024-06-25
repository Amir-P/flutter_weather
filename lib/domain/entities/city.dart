import 'package:flutter_weather/domain/entities/coordinates.dart';

class City {
  final String name, state, country;
  final LocationCoordinates coordinates;

  const City({
    required this.name,
    required this.state,
    required this.country,
    required this.coordinates,
  });
}
