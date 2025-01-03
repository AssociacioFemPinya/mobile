part of 'ronda_view_bloc.dart';

sealed class RondaViewEvent extends Equatable {
  const RondaViewEvent();

  @override
  List<Object> get props => [];
}

class RondaLoadEvent extends RondaViewEvent {
  final int id;
  RondaLoadEvent({required this.id});
}
