part of 'rondes_list_bloc.dart';

sealed class RondesListEvents extends Equatable {
  const RondesListEvents();

  @override
  List<Object> get props => [];
}

class LoadRondesList extends RondesListEvents {
  final String email;

  LoadRondesList({required this.email});

  @override
  String toString() => 'Rondes button pressed { email : ${this.email} }';
}
