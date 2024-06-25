import 'package:flutter_weather/domain/entities/city.dart';
import 'package:flutter_weather/domain/entities/coordinates.dart';

class Location {
  final String title;
  final LocationCoordinates coordinates;

  const Location({required this.title, required this.coordinates});

  Location.fromCity(City city)
      : title = '${city.name}, ${city.country}',
        coordinates = city.coordinates;
}
