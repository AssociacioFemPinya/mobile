part of 'user_profile_view_bloc.dart';

sealed class UserProfileViewEvent extends Equatable {
  const UserProfileViewEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfile extends UserProfileViewEvent {
  const LoadUserProfile();
}
