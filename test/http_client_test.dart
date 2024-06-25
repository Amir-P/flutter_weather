import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/core/http_client.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late Dio dio;

  setUp(() => dio = MockDio());

  test('delegates requests to dio', () async {
    final response = <String, dynamic>{'response': 'data'};
    final client = HttpClient(dio);
    when(() => dio.request<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'),
            ))
        .thenAnswer((_) async =>
            Response(requestOptions: RequestOptions(path: ''), data: response));
    final path = '/path';
    final data = {'body': 'data'};
    final queryParameters = {'query': 'data'};
    final actualResponse = await client.request<Map<String, dynamic>>(path,
        data: data, method: Method.put, queryParameters: queryParameters);
    verify(
      () => dio.request<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: any(
          named: 'options',
          that: predicate((Options? t) => t?.method == 'PUT'),
        ),
      ),
    );
    expect(actualResponse, response);
  });
}
