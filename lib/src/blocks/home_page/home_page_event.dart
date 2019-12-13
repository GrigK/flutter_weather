import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class InitEvent extends HomePageEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
