import 'package:flutter_weather/core/assert.dart';

@Assert(weatherApiKey != '', 'Please provide weather_api_key')
const String weatherApiKey = String.fromEnvironment('weather_api_key');
@Assert(weatherApiUrl != '', 'Please provide weather_api_url')
const String weatherApiUrl = String.fromEnvironment('weather_api_url');
