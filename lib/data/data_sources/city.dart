import 'package:flutter_weather/core/globals.dart';
import 'package:flutter_weather/data/data_sources/remote.dart';
import 'package:flutter_weather/data/dtos/city.dart';
import 'package:injectable/injectable.dart';

abstract class CityRemoteDatasource {
  Future<List<CityDTO>> getCities(String query);
}

@LazySingleton(as: CityRemoteDatasource)
class CityRemoteDataSourceImpl extends RemoteDataSource
    implements CityRemoteDatasource {
  const CityRemoteDataSourceImpl(super.http);

  @override
  Future<List<CityDTO>> getCities(String query) async {
    final List<dynamic> response = await http.request(
      '/geo/1.0/direct',
      queryParameters: <String, dynamic>{
        'q': query,
        'limit': 5,
        'appid': config.weatherApiKey,
      },
    );
    return response.map<CityDTO>((dynamic e) => CityDTO.fromMap(e)).toList();
  }
}
