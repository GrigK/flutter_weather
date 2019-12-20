import 'package:flutter/material.dart';

import 'package:flutter_weather/src/models/models.dart';

class WeatherConditions extends StatelessWidget {
  final WeatherCondition condition;

  const WeatherConditions({Key key,@required this.condition}) :
        assert(condition!=null),
        super(key: key);

  @override
  Widget build(BuildContext context) => _mapConditionToImage(condition);

  Image _mapConditionToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.clear:
        image = Image.asset('images/clear.png');
        break;
      case WeatherCondition.lightCloud:
        image = Image.asset('images/lightcloud.png');
        break;
      case WeatherCondition.hail:
        image = Image.asset('images/hail.png');
        break;
      case WeatherCondition.snow:
        image = Image.asset('images/snow.png');
        break;
      case WeatherCondition.sleet:
        image = Image.asset('images/sleet.png');
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset('images/cloudy.png');
        break;
      case WeatherCondition.heavyRain:
        image = Image.asset('images/heavyrain.png');
        break;
      case WeatherCondition.lightRain:
        image = Image.asset('images/lightcloud.png');
        break;
      case WeatherCondition.showers:
        image = Image.asset('images/rainy.png');
        break;
      case WeatherCondition.thunderstorm:
        image = Image.asset('images/thunderstorm.png');
        break;
      case WeatherCondition.unknown:
        image = Image.asset('images/clear.png');
        break;
    }
    return image;
  }
}
