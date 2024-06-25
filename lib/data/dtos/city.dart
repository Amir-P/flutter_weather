import 'package:equatable/equatable.dart';
import 'package:flutter_weather/domain/entities/city.dart';
import 'package:flutter_weather/domain/entities/coordinates.dart';

class CityDTO extends Equatable {
  final String name, state, country;
  final double lat, lon;
  final Map<String, dynamic>? localNames;

  const CityDTO({
    required this.name,
    required this.state,
    required this.country,
    required this.lat,
    required this.lon,
    this.localNames,
  });

  CityDTO.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        state = map['state'],
        country = map['country'],
        lat = map['lat'],
        lon = map['lon'],
        localNames = map['local_names'];

  City get toEntity => City(
        name: name,
        state: state,
        country: country,
        coordinates: LocationCoordinates(lat: lat, lon: lon),
      );

  @override
  List<Object?> get props => [name, state, country, lat, lon, localNames];
}
