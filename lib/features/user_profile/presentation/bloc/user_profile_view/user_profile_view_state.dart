part of 'user_profile_view_bloc.dart';

sealed class UserProfileViewState extends Equatable {
  const UserProfileViewState();

  @override
  List<Object> get props => [];
}

final class UserProfileViewInitial extends UserProfileViewState {}

class UserProfileLoadInProgress extends UserProfileViewState {}

class UserProfileLoadSuccess extends UserProfileViewState {
  final UserProfileEntity user;

  const UserProfileLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserProfileLoadFailure extends UserProfileViewState {
  final String message;

  const UserProfileLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
