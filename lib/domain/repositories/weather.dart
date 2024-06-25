import 'package:flutter_weather/domain/entities/coordinates.dart';
import 'package:flutter_weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(LocationCoordinates coordinates);
}
