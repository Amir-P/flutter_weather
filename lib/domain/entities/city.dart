import 'package:flutter_weather/domain/entities/coordinates.dart';

class City {
  final String name, country;
  final String? state;
  final LocationCoordinates coordinates;

  const City({
    required this.name,
    required this.country,
    required this.coordinates,
    this.state,
  });
}
