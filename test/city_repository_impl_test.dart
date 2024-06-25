import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/core/cache_store.dart';
import 'package:flutter_weather/data/data_sources/city.dart';
import 'package:flutter_weather/data/dtos/city.dart';
import 'package:flutter_weather/data/repositories/city.dart';
import 'package:flutter_weather/domain/entities/city.dart';
import 'package:mocktail/mocktail.dart';

class MockDataSource extends Mock implements CityRemoteDatasource {}

class MockCityDTO extends Mock implements CityDTO {}

class MockCity extends Mock implements City {}

void main() {
  late CityRemoteDatasource datasource;

  setUp(() => datasource = MockDataSource());

  test('gets cities from cache if available', () async {
    final mockCityDto = MockCityDTO();
    final mockCity = MockCity();
    when(() => mockCityDto.toEntity).thenReturn(mockCity);
    final cacheStore = MemCacheStore();
    final repository = CityRepositoryImpl(cacheStore, datasource);
    final query = 'query';
    cacheStore.put('${query}_cities', [mockCityDto]);
    final cities = await repository.getCities(query);
    expect(cities, [mockCity]);
    verifyZeroInteractions(datasource);
  });

  test('gets cities from remote data source if cache not available', () async {
    final mockCityDto = MockCityDTO();
    final mockCity = MockCity();
    when(() => mockCityDto.toEntity).thenReturn(mockCity);
    when(() => datasource.getCities(any()))
        .thenAnswer((_) => Future.value([mockCityDto]));
    final cacheStore = MemCacheStore();
    final repository = CityRepositoryImpl(cacheStore, datasource);
    final query = 'query';
    expect(await cacheStore.get('${query}_cities'), null);
    final cities = await repository.getCities(query);
    expect(cities, [mockCity]);
    expect(await cacheStore.get('${query}_cities'), [mockCityDto]);
    verify(() => datasource.getCities(query));
  });
}
