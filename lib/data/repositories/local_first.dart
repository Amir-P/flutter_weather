import 'package:flutter_weather/core/cache_store.dart';

abstract class LocalFirstRepository {
  final CacheStore _cacheStore;

  const LocalFirstRepository(this._cacheStore);

  Future<Entity> get<Entity extends Object, DTO extends Object>(String cacheKey,
      Future<DTO> Function() remoteRequest, Entity Function(DTO) mapper) async {
    final DTO dto =
        await _cacheStore.get<DTO>(cacheKey).catchError((_) => null) ??
            await remoteRequest().then((DTO v) {
              _cacheStore.put(cacheKey, v);
              return v;
            });
    return mapper(dto);
  }
}
