import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather/generated/i18n.dart';
import 'package:flutter_weather/src/blocks/theme_block.dart';

import 'package:flutter_weather/src/blocks/weather/bloc.dart';
import 'package:flutter_weather/src/ui/widgets/widgets.dart';
import 'package:flutter_weather/src/models/models.dart';

import './pages.dart';

class WeatherPage extends StatefulWidget {
  State<WeatherPage> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).titleWeatherPage),
        actions: _actions(context),
      ),
      body: Center(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (BuildContext context, WeatherState state){
//            if (state is WeatherLoadedState){
//              BlocProvider.of(context)
//            }
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: _bodyBuild,
          ),
        ),
      ),
    );
  }

  List<Widget> _actions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () async {
          final city = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CitySelectionPage(),
            ),
          );
          if (city != null) {
            BlocProvider.of<WeatherBloc>(context)
                .add(FetchWeatherEvent(city: city));
          }
        },
      ),
      IconButton(
          icon: Icon(Icons.brightness_medium),
          onPressed: () {
            // Используем глобальный BLoC (смена темы)
            BlocProvider.of<ThemeBloc>(context).add(ThemeEvent.toggle);
          }),
      SizedBox(
        width: 16.0,
      )
    ];
  }

  Widget _bodyBuild(BuildContext context, WeatherState state) {
    if (state is WeatherEmptyState) {
      return Center(child: Text('Please Select a Location'));
    }
    if (state is WeatherLoadingState) {
      return Center(child: CircularProgressIndicator());
    }
    if (state is WeatherLoadedState) {
      final Weather weather = state.weather;
      // реализация перезагрузки страницы
      return RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<WeatherBloc>(context)
              .add(RefreshWeatherEvent(city: state.weather.location),);
          return _refreshCompleter.future;
        },
        child: _weatherListView(context, weather),
      );
    }
    // Если произошла ошибка
    if (state is WeatherErrorState) {
      return Text(
        'Something went wrong!',
        style: TextStyle(color: Colors.red),
      );
    }
    return Center();
  }

  Widget _weatherListView(BuildContext context, Weather weather) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 100.0),
          child: Center(
            child: Location(location: weather.location),
          ),
        ),
        Center(
          child: LastUpdated(dateTime: weather.lastUpdated),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: Center(
            child: CombinedWeatherTemperature(
              weather: weather,
            ),
          ),
        ),
      ],
    );
  }
}
