import 'package:flutter/foundation.dart';

class Config {
  final String weatherApiKey;
  final String weatherApiUrl;

  Config.fromEnvironment()
      : assert(_weatherApiKey != '' && _weatherApiUrl != ''),
        weatherApiKey = _weatherApiKey,
        weatherApiUrl = _weatherApiUrl;

  @visibleForTesting
  Config.override(this.weatherApiKey, this.weatherApiUrl);
}

const String _weatherApiKey = String.fromEnvironment('weather_api_key');
const String _weatherApiUrl = String.fromEnvironment('weather_api_url');

late final Config config;
