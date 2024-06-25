import 'package:flutter_weather/core/http_client.dart';

abstract class RemoteDataSource {
  final HttpClient http;

  const RemoteDataSource(this.http);
}
