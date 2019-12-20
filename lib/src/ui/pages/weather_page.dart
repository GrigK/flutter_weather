import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather/generated/i18n.dart';
import 'package:flutter_weather/src/blocks/theme_block.dart';

import 'package:flutter_weather/src/blocks/weather/bloc.dart';
import 'package:flutter_weather/src/repositories/repositories.dart';
import 'package:flutter_weather/src/ui/widgets/widgets.dart';

import './pages.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).titleWeatherPage),
        actions: _actions(context),
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: _bodyBuild,
        ),
      ),
    );
  }

  List<Widget> _actions(BuildContext context){
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

  Widget _bodyBuild(BuildContext context, WeatherState state){
    if (state is WeatherEmptyState) {
      return Center(child: Text('Please Select a Location'));
    }
    if (state is WeatherLoadingState) {
      return Center(child: CircularProgressIndicator());
    }
    if (state is WeatherLoadedState) {
      final weather = state.weather;

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
    if (state is WeatherErrorState) {
      return Text(
        'Something went wrong!',
        style: TextStyle(color: Colors.red),
      );
    }
    return Center();
  }
}
