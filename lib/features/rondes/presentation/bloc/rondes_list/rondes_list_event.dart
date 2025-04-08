part of 'rondes_list_bloc.dart';

sealed class RondesListEvent extends Equatable {
  const RondesListEvent();

  @override
  List<Object> get props => [];
}

class LoadRondesList extends RondesListEvent {

  LoadRondesList();

  @override
  String toString() => 'Rondes button pressed';
}
