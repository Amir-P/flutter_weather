import 'package:flutter_weather/domain/entities/city.dart';

abstract class CityRepository {
  Future<List<City>> getCities(String query);
}
