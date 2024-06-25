import 'dart:async';

import 'package:injectable/injectable.dart';

abstract class CacheStore {
  Future<T?> get<T>(Object key);

  Future<void> put(Object key, Object value);
}

@LazySingleton(as: CacheStore)
class MemCacheStore implements CacheStore {
  final Map<Object, Object> _memCache = <Object, Object>{};

  @override
  Future<T?> get<T>(Object key) => Future<T?>.value(_memCache[key] as T?);

  @override
  Future<void> put(Object key, Object value) async => _memCache[key] = value;
}
