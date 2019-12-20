import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

/// Когда пользователь вводит город, мы добавляем событие FetchWeather с
/// указанным городом, и наш блок будет отвечать за выяснение погоды и
/// возвращать новый WeatherState.
class FetchWeatherEvent extends WeatherEvent {
  final String city;

  const FetchWeatherEvent({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}

// событие на обновление погоды для текущего города
class RefreshWeatherEvent extends WeatherEvent {
  final String city;

  const RefreshWeatherEvent({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}
