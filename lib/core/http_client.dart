import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'exceptions.dart';

typedef Request<T> = Future<Response<T>> Function();

enum Method {
  get('GET'),
  post('POST'),
  put('PUT'),
  delete('DELETE'),
  update('UPDATE'),
  patch('PATCH');

  final String name;

  const Method(this.name);
}

@injectable
class HttpClient {
  final Dio _dio;

  const HttpClient(this._dio);

  Future<T> request<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Method method = Method.get,
  }) async {
    try {
      final Response<T> response = await _dio.request(
        path,
        options: Options(method: method.name),
        data: data,
        queryParameters: queryParameters,
      );
      return response.data!;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw ServerException(
            statusCode: e.response?.statusCode, message: 'A server error');
      }
      if (e.type == DioExceptionType.cancel) {
        throw const RequestCancelledException();
      }
      if (e.type.isTimeout) {
        throw const RequestTimedOutException();
      }
      rethrow;
    }
  }
}

extension on DioExceptionType {
  bool get isTimeout =>
      this == DioExceptionType.connectionTimeout ||
      this == DioExceptionType.receiveTimeout ||
      this == DioExceptionType.sendTimeout;
}
