import 'package:equatable/equatable.dart';

/// состояние погоды см https://www.metaweather.com/api/ [Weather States]
enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition condition;
  final double airPressure;
  final String applicableDate;
  final String created;
  final int humidity;
  final int id;
  final double maxTemp;
  final double minTemp;
  final int predictability;
  final double temp;
  final double visibility;
  final String weatherStateAbbr;
  final String formattedCondition;
  final double windDirection;
  final String windDirectionCompass;
  final double windSpeed;
  final DateTime lastUpdated;
  final int locationId;
  final String location;

  final String lattLong;
  final String sunRise;
  final String sunSet;

  const Weather({
    this.condition,
    this.airPressure,
    this.applicableDate,
    this.created,
    this.humidity,
    this.id,
    this.maxTemp,
    this.minTemp,
    this.predictability,
    this.temp,
    this.visibility,
    this.weatherStateAbbr,
    this.formattedCondition,
    this.windDirection,
    this.windDirectionCompass,
    this.windSpeed,
    this.lastUpdated,
    this.locationId,
    this.location,
    this.lattLong,
    this.sunRise,
    this.sunSet
  });

  @override
  List<Object> get props => [
    condition,
    airPressure,
    applicableDate,
    created,
    humidity,
    id,
    maxTemp,
    minTemp,
    predictability,
    temp,
    visibility,
    weatherStateAbbr,
    formattedCondition,
    windDirection,
    windDirectionCompass,
    windSpeed,
    lastUpdated,
    location,
    lattLong,
    sunSet,
    sunRise
  ];

//  factory Weather.fromJson(Map<String, dynamic> json)
  /// модель ответа https://www.metaweather.com/api/location/2122265/
  /// [day] - 0..5 прогноз может быть до 6 дней
  static Weather fromJson(dynamic json, {int day = 0}) {
    assert(day >= 0);
    day = day % 6; // в прогнозе только 6 дней

    final consolidatedWeather = json['consolidated_weather'][day];

    return Weather(
      condition: _mapStringToWeatherCondition(
          consolidatedWeather['weather_state_abbr']),
      airPressure: consolidatedWeather['air_pressure'],
      applicableDate: consolidatedWeather['applicable_date'],
      created: consolidatedWeather['created'],
      humidity: consolidatedWeather['humidity'],
      id: consolidatedWeather['id'],
      maxTemp: consolidatedWeather['max_temp'],
      minTemp: consolidatedWeather['min_temp'],
      predictability: consolidatedWeather['predictability'],
      temp: consolidatedWeather['the_temp'],
      visibility: consolidatedWeather['visibility'],
      weatherStateAbbr: consolidatedWeather['weather_state_abbr'],
      formattedCondition: consolidatedWeather['weather_state_name'],
      windDirection: consolidatedWeather['wind_direction'],
      windDirectionCompass: consolidatedWeather['wind_direction_compass'],
      windSpeed: consolidatedWeather['wind_speed'],
      lastUpdated: DateTime.now(),
      locationId: json['woeid'] as int,
      location: json['title'],
      lattLong: json['latt_long'],
      sunRise: json['sun_rise'],
      sunSet:  json['sun_set']
    );
  }

  /// расшифровка аббревиатуры состояния погоды
  /// возвращает состояние погоды [WeatherCondition]
  static WeatherCondition _mapStringToWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'sn':
        state = WeatherCondition.snow;
        break;
      case 'sl':
        state = WeatherCondition.sleet;
        break;
      case 'h':
        state = WeatherCondition.hail;
        break;
      case 't':
        state = WeatherCondition.thunderstorm;
        break;
      case 'hr':
        state = WeatherCondition.heavyRain;
        break;
      case 'lr':
        state = WeatherCondition.lightRain;
        break;
      case 's':
        state = WeatherCondition.showers;
        break;
      case 'hc':
        state = WeatherCondition.heavyCloud;
        break;
      case 'lc':
        state = WeatherCondition.lightCloud;
        break;
      case 'c':
        state = WeatherCondition.clear;
        break;
      default:
        state = WeatherCondition.unknown;
    }
    return state;
  }
}
