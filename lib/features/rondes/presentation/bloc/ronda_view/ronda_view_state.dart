part of 'ronda_view_bloc.dart';

sealed class RondaViewState extends Equatable {
  const RondaViewState();

  @override
  List<Object> get props => [];
}

final class RondaViewInitial extends RondaViewState {}

final class RondaViewLoadFailureState extends RondaViewState {
  final String failure;
  RondaViewLoadFailureState({required this.failure});
}

final class RondaViewLoadFailureStateEmptyUri extends RondaViewState
    implements RondaViewLoadStateWithRonda {
  final RondaEntity ronda;
  RondaViewLoadFailureStateEmptyUri({required this.ronda});
}

class RondaViewLoadStateWithRonda {
  final RondaEntity ronda;
  RondaViewLoadStateWithRonda({required this.ronda});
}

final class RondaViewLoadFailureStateWrongUri extends RondaViewState
    implements RondaViewLoadStateWithRonda {
  final RondaEntity ronda;
  RondaViewLoadFailureStateWrongUri({required this.ronda});
}

final class RondaViewLoadSuccessState extends RondaViewState
    implements RondaViewLoadStateWithRonda {
  final RondaEntity ronda;
  RondaViewLoadSuccessState({required this.ronda});
}
