import 'package:flutter_weather/data/data_sources/city.dart';
import 'package:flutter_weather/data/dtos/city.dart';
import 'package:flutter_weather/data/repositories/local_first.dart';
import 'package:flutter_weather/domain/entities/city.dart';
import 'package:flutter_weather/domain/repositories/city.dart';
import 'package:injectable/injectable.dart';

const String _citiesCacheKeySuffix = 'cities';

@injectable
class CityRepositoryImpl extends LocalFirstRepository
    implements CityRepository {
  final CityRemoteDatasource datasource;

  const CityRepositoryImpl(super.cacheStore, this.datasource);

  @override
  Future<List<City>> getCities(String query) => get(
        '${query}_$_citiesCacheKeySuffix',
        () => datasource.getCities(query),
        (List<CityDTO> dtos) => dtos.map((CityDTO e) => e.toEntity).toList(),
      );
}
