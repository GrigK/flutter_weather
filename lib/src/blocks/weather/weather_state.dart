import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_weather/src/models/models.dart';

/// WeatherEmptyState - начальное состояние, в котором не будет данных о погоде,
///                потому что пользователь еще не выбрал город
/// WeatherLoadingState - состояние загрузки погоды для города
/// WeatherLoadedState - погода успешно загруженя
/// WeatherErrorState - ошибка получения погоды
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmptyState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final Weather weather;

  const WeatherLoadedState({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherErrorState extends WeatherState {}
