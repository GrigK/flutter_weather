import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './generated/i18n.dart';
import './src/blocks/simple_bloc_delegate.dart';
import './src/blocks/theme_block.dart';

import 'package:flutter_weather/src/blocks/weather/bloc.dart';
import 'package:flutter_weather/src/repositories/repositories.dart';
import 'package:flutter_weather/src/ui/pages/pages.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherAPIClient: WeatherAPIClient(
      httpClient: http.Client(),
    ),
  );

  return runApp(MyApp(weatherRepository: weatherRepository));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          /// ThemeBloc - это глобальный BLoC
          /// доступный из любого места MaterialApp через
          /// BlocProvider.of<ThemeBloc>(context)
          return MaterialApp(
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
//            localeResolutionCallback: S.delegate.resolution(fallback: new Locale("en", "")),

            onGenerateTitle: (context) => S.of(context).appName,
            home: BlocProvider(
              create: (context) =>
                  WeatherBloc(weatherRepository: weatherRepository),
              child: WeatherPage(),
            ),
            theme: theme,
          );
        },
      ),
    );
  }
}
