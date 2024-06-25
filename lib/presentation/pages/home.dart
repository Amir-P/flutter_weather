import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/widgets/location_search_view.dart';
import 'package:flutter_weather/presentation/widgets/weather_display.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Weather')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            LocationSearchView(),
            SizedBox(height: 16),
            Expanded(child: WeatherDisplay()),
          ],
        ),
      ),
    );
  }
}
