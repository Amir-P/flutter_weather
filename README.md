# flutter_weather

A simple weather application using [OpenWeather](https://openweathermap.org) API written in Flutter.

## Getting Started

To run the application you need to provide weather API key and url. To do so you can create your own envionment file as following, and then use VSCode launch config or run `flutter run --dart-define-from-file=your_env_file.json`:

```json
{
    "weather_api_key": "YOUR_API_KEY",
    "weather_api_url": "https://api.openweathermap.org/data/2.5/weather"
}
```

Or `flutter run --dart-define=weather_api_key=YOUR_API_KEY --dart-define=weather_api_url=https://api.openweathermap.org/data/2.5/weather`.
