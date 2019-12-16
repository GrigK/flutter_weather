import 'dart:async';
import 'package:meta/meta.dart';

import 'package:flutter_weather/src/models/models.dart';
import 'weather_api_client.dart';

class WeatherRepository {
  final WeatherAPIClient weatherAPIClient;

  WeatherRepository({@required this.weatherAPIClient})
      : assert(weatherAPIClient != null);

  /// получить прогноз на один день для первого найденного города
  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherAPIClient.getFirstLocationId(city);
    return await weatherAPIClient.fetchWeather(locationId);
  }

  /// вохвращает список найденных городов по запросу [city]
  Future<List<City>> getCities(String city) async {
    return await weatherAPIClient.getLocationCities(city);
  }

  /// возвращает прогноз на 6 дней для данного города
  Future<List<Weather>> getForecastWeathers(City city) async {
    return await weatherAPIClient.fetchForecastWeathers(city.woeid);
  }
}
