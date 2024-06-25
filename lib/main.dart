import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/app.dart';
import 'package:flutter_weather/core/globals.dart';

void main() {
  config = Config.fromEnvironment();

  runApp(const ProviderScope(child: WeatherApp()));
}
