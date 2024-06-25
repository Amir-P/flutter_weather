import 'package:flutter_weather/core/globals.dart';
import 'package:flutter_weather/data/data_sources/remote.dart';
import 'package:flutter_weather/data/dtos/weather.dart';
import 'package:flutter_weather/domain/entities/coordinates.dart';
import 'package:injectable/injectable.dart';

abstract class WeatherRemoteDatasource {
  Future<WeatherDTO> getWeather(LocationCoordinates coordinates);
}

@LazySingleton(as: WeatherRemoteDatasource)
class WeatherRemoteDataSourceImpl extends RemoteDataSource
    implements WeatherRemoteDatasource {
  const WeatherRemoteDataSourceImpl(super.http);

  @override
  Future<WeatherDTO> getWeather(LocationCoordinates coordinates) async {
    final Map<String, dynamic> response = await http.request(
      '/data/2.5/weather',
      queryParameters: <String, dynamic>{
        'lat': coordinates.lat,
        'lon': coordinates.lon,
        'appid': config.weatherApiKey,
      },
    );
    return WeatherDTO.fromMap(response);
  }
}
