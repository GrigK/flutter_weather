import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_weather/src/models/models.dart';

class WeatherAPIClient {
  static const String _baseUrl ='https://www.metaweather.com';
  static const String _baseLocation = '$_baseUrl/api/location/search/?query=';
  static const String _baseWeather = '$_baseUrl/api/location/';
  final http.Client httpClient;

  WeatherAPIClient({@required this.httpClient}) : assert(httpClient!= null);

  /// возвращает id первого найденного города по названию [city]
  Future<int> getLocationIdFirst(String city) async {
    final locationUrl = '$_baseLocation$city';
    final locationResponse = await this.httpClient.get(locationUrl);

    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }

    final List<dynamic> locationJson = jsonDecode(locationResponse.body) as List;

    //TODO: внимание! если список пустой то будет ошибка. Надо исправить
    return(locationJson.first)['woeid'];
  }

  /// возвращает список [List<City>] найденных городов по запросу [city]
  Future<List<City>> getLocationCities(String city) async {
    final locationUrl = '$_baseLocation$city';
    // внимание! - если [city] - это часть названия города то будет возвращен
    // список найденных городов
    final locationResponse = await this.httpClient.get(locationUrl);

    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }

    final List<dynamic> locationJson = jsonDecode(locationResponse.body) as List;
    return locationJson.map((x) => City.fromJson(x)).toList();
  }

  /// возвращает прогноз на первый день данного города по его идентификатору
  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$_baseWeather$locationId';
    final weatherResponse = await this.httpClient.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonEncode(weatherResponse.body);
    // по умолчанию прогноз на сегодняшний день
    // если надо на другой, то надо выбирать параметр [day] 0..5
    return Weather.fromJson(weatherJson);
  }

  /// возвращает прогноз на 6 дней для данного города
  Future<List<Weather>> fetchForecastWeathers(int locationId) async {
    final weatherUrl = '$_baseWeather$locationId';
    final weatherResponse = await this.httpClient.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weathers for location');
    }

    final weatherJson = jsonEncode(weatherResponse.body);

    return Weather.fromJsonToForecastList(weatherJson);
  }

}