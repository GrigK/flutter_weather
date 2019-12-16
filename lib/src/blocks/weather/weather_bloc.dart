import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';
import 'package:flutter_weather/src/repositories/repositories.dart';
import 'package:flutter_weather/src/models/models.dart';

/// преобразует WeatherEvents в WeatherStates и зависит от WeatherRepository
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmptyState();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherEvent) {
      // состояние загрузки
      yield WeatherLoadingState();

      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoadedState(weather: weather);
      } catch(_){
        yield WeatherErrorState();
      }

    }
  }
}
