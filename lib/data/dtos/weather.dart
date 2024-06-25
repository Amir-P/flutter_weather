import 'package:equatable/equatable.dart';
import 'package:flutter_weather/domain/entities/weather.dart';

class WeatherDTO extends Equatable {
  final int id, cod;
  final double temperature;
  final String description, icon;

  const WeatherDTO({
    required this.id,
    required this.cod,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory WeatherDTO.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> weatherObject = map['weather'].first;
    return WeatherDTO(
      id: map['id'],
      cod: map['cod'],
      temperature: map['main']['temp'],
      description: weatherObject['description'],
      icon: weatherObject['icon'],
    );
  }

  Weather get toEntity => Weather(
        temperature: temperature,
        description: description,
        iconUrl: 'https://openweathermap.org/img/wn/$icon@2x.png',
      );

  @override
  List<Object?> get props => <Object?>[id, cod, temperature, description, icon];
}
