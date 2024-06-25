import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/core/globals.dart';
import 'package:flutter_weather/core/http_client.dart';
import 'package:flutter_weather/data/data_sources/weather.dart';
import 'package:flutter_weather/data/dtos/weather.dart';
import 'package:flutter_weather/domain/entities/coordinates.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late HttpClient httpClient;

  setUpAll(() {
    config = Config.override('weatherApiKey', 'weatherApiUrl');
    registerFallbackValue(Method.get);
  });

  setUp(() => httpClient = MockHttpClient());

  test('delegates request to http client and returns mapped data', () async {
    when(() => httpClient.request<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          method: any(named: 'method'),
        )).thenAnswer((_) => Future.value(_data));
    final weather = WeatherDTO.fromMap(_data);
    final coordinates = LocationCoordinates(lat: 1.2, lon: 2.3);
    final actualWeather =
        await WeatherRemoteDataSourceImpl(httpClient).getWeather(coordinates);
    expect(actualWeather, weather);
    verify(() => httpClient.request<Map<String, dynamic>>(
          '/data/2.5/weather',
          queryParameters: {
            'lat': coordinates.lat,
            'lon': coordinates.lon,
            'appid': config.weatherApiKey,
          },
          method: Method.get,
          data: null,
        ));
  });
}

const _data = {
  "coord": {"lon": 10.99, "lat": 44.34},
  "weather": [
    {"id": 501, "main": "Rain", "description": "moderate rain", "icon": "10d"}
  ],
  "base": "stations",
  "main": {
    "temp": 298.48,
    "feels_like": 298.74,
    "temp_min": 297.56,
    "temp_max": 300.05,
    "pressure": 1015,
    "humidity": 64,
    "sea_level": 1015,
    "grnd_level": 933
  },
  "visibility": 10000,
  "wind": {"speed": 0.62, "deg": 349, "gust": 1.18},
  "rain": {"1h": 3.16},
  "clouds": {"all": 100},
  "dt": 1661870592,
  "sys": {
    "type": 2,
    "id": 2075663,
    "country": "IT",
    "sunrise": 1661834187,
    "sunset": 1661882248
  },
  "timezone": 7200,
  "id": 3163858,
  "name": "Zocca",
  "cod": 200
};
