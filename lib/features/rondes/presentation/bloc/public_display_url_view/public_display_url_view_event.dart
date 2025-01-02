part of 'public_display_url_view_bloc.dart';

sealed class PublicDisplayUrlViewEvent extends Equatable {
  const PublicDisplayUrlViewEvent();

  @override
  List<Object> get props => [];
}

class PublicDisplayUrlLoadEvent extends PublicDisplayUrlViewEvent {
  final String email;
  PublicDisplayUrlLoadEvent({required this.email});
}
