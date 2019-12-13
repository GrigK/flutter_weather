import 'package:equatable/equatable.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class InitialHomePageState extends HomePageState {
  @override
  List<Object> get props => [];
}
