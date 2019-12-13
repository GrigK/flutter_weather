import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  @override
  HomePageState get initialState => InitialHomePageState();

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is InitEvent) {
      yield InitialHomePageState();
    }
  }
}
