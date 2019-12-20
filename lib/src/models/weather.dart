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
  final String created;
  final double maxTemp;
  final double minTemp;
  final double temp;
  final String formattedCondition;
  final DateTime lastUpdated;
  final int locationId;
  final String location;

  final double airPressure;
  final String applicableDate;
  final int humidity;
  final int predictability;
  final double visibility;
  final double windDirection;
  final String windDirectionCompass;
  final double windSpeed;

  final String lattLong;
  final String sunRise;
  final String sunSet;

  const Weather(
      {this.condition,
      this.created,
      this.maxTemp,
      this.minTemp,
      this.temp,
      this.formattedCondition,
      this.lastUpdated,
      this.locationId,
      this.location,
      this.airPressure,
      this.applicableDate,
      this.humidity,
      this.predictability,
      this.visibility,
      this.windDirection,
      this.windDirectionCompass,
      this.windSpeed,
      this.lattLong,
      this.sunRise,
      this.sunSet});

  @override
  List<Object> get props => [
        condition,
        created,
        maxTemp,
        minTemp,
        temp,
        formattedCondition,
        lastUpdated,
        location,
        locationId,
        airPressure,
        applicableDate,
        humidity,
        predictability,
        visibility,
        windDirection,
        windDirectionCompass,
        windSpeed,
        lattLong,
        sunSet,
        sunRise
      ];

  /// модель ответа https://www.metaweather.com/api/location/2122265/
  /// [day] - 0..5 прогноз может быть до 6 дней
  static Weather fromJson(dynamic json, {int day = 0}) {
    assert(day >= 0);
    day = day % 6; // в прогнозе только 6 дней если ичкать по location

    final consolidatedWeather = json['consolidated_weather'][day];

    return Weather(
        condition: _mapStringToWeatherCondition(
            consolidatedWeather['weather_state_abbr']),
        created: consolidatedWeather['created'],
        temp: consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        minTemp: consolidatedWeather['min_temp'] as double,
        formattedCondition: consolidatedWeather['weather_state_name'],
        lastUpdated: DateTime.now(),
        locationId: json['woeid'] as int,
        location: json['title'],
        airPressure: consolidatedWeather['air_pressure'] as double,
        applicableDate: consolidatedWeather['applicable_date'],
        humidity: consolidatedWeather['humidity'] as int,
        predictability: consolidatedWeather['predictability'] as int,
        visibility: consolidatedWeather['visibility'] as double,
        windDirection: consolidatedWeather['wind_direction'] as double,
        windDirectionCompass: consolidatedWeather['wind_direction_compass'],
        windSpeed: consolidatedWeather['wind_speed'] as double,
        lattLong: json['latt_long'],
        sunRise: json['sun_rise'],
        sunSet: json['sun_set']);
  }

  // возвращает прогноз на 6 дней
  static List<Weather> fromJsonToForecastList(dynamic json) {
    return [0, 1, 2, 3, 4, 5].map((x) => fromJson(json, day: x)).toList();
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
