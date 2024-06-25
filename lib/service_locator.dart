import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather/core/globals.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator.config.dart';

final GetIt sl = GetIt.I;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void registerServices() => sl.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio {
    final BaseOptions baseOption = BaseOptions(baseUrl: config.weatherApiUrl);
    final Dio dio = Dio(baseOption);
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        logPrint: (Object object) => debugPrint(object.toString()),
      ));
    }
    return dio;
  }
}
