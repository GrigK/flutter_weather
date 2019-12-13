import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/i18n.dart';
import '../../blocks/home_page/bloc.dart';
import '../../blocks/theme_block.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// //  в случае усложнения структуры страницы могут понадобиться:
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: _provider(context),
    );
  }

  AppBar _appBar(BuildContext context){
    return AppBar(
      title: Text(S.of(context).titleHomePage),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.brightness_medium),
            onPressed: () {
              // Используем глобальный BLoC (смена темы)
              BlocProvider.of<ThemeBloc>(context).add(ThemeEvent.toggle);
            }),
        SizedBox(
          width: 16.0,
        )
      ],
    );
  }

  Widget _provider(BuildContext context){
    return BlocProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: _bodyState),
    );
  }

  Widget _bodyState(BuildContext context, HomePageState state){
    // обработчики состояний HomePageBloc:
    if (state is InitialHomePageState) {
      return Center(child: Text('Init HomePageState BLoC'),);
    }

    return Center(child: Text('Not state BLoC'),);
  }

}