import 'package:flutter_weather/data/data_sources/weather.dart';
import 'package:flutter_weather/data/dtos/weather.dart';
import 'package:flutter_weather/data/repositories/local_first.dart';
import 'package:flutter_weather/domain/entities/coordinates.dart';
import 'package:flutter_weather/domain/entities/weather.dart';
import 'package:flutter_weather/domain/repositories/weather.dart';
import 'package:injectable/injectable.dart';

const String _weatherCacheKeySuffix = 'weather';

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl extends LocalFirstRepository
    implements WeatherRepository {
  final WeatherRemoteDatasource datasource;

  const WeatherRepositoryImpl(super.cacheStore, this.datasource);

  @override
  Future<Weather> getWeather(LocationCoordinates coordinates) => get(
        coordinates.toKey,
        () => datasource.getWeather(coordinates),
        (WeatherDTO dto) => dto.toEntity,
      );
}

extension on LocationCoordinates {
  String get toKey => lat.toString() + lon.toString() + _weatherCacheKeySuffix;
}
