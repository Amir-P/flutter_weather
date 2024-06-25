import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/app.dart';
import 'package:flutter_weather/core/globals.dart';
import 'package:flutter_weather/service_locator.dart';

void main() {
  config = Config.fromEnvironment();

  registerServices();

  runApp(const ProviderScope(child: WeatherApp()));
}
