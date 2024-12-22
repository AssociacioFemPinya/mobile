part of 'rondes_list_bloc.dart';

sealed class RondesListState extends Equatable {
  const RondesListState();

  @override
  List<Object> get props => [];
}

final class RondesListInitial extends RondesListState {}

final class RondesListLoadSuccessState extends RondesListState {
  final List<RondaEntity> rondes;

  RondesListLoadSuccessState(this.rondes);

  @override
  List<Object> get props => [];
}

final class RondesListLoadFailureState extends RondesListState {
  final String failure;
  RondesListLoadFailureState(this.failure);
}
