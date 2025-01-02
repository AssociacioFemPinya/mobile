part of 'public_display_url_view_bloc.dart';

sealed class PublicDisplayUrlViewState extends Equatable {
  const PublicDisplayUrlViewState();

  @override
  List<Object> get props => [];
}

final class PublicDisplayUrlViewInitial extends PublicDisplayUrlViewState {}

final class PublicDisplayUrlLoadFailureState extends PublicDisplayUrlViewState {
  final String failure;

  PublicDisplayUrlLoadFailureState({required this.failure});
}

final class PublicDisplayUrlLoadSuccessState extends PublicDisplayUrlViewState
    implements PublicDisplayUrlViewStateWithUrl {
  final PublicDisplayUrlEntity publicDisplayUrl;

  PublicDisplayUrlLoadSuccessState({required this.publicDisplayUrl});
}

final class PublicDisplayUrlLoadFailureStateEmptyUri
    extends PublicDisplayUrlViewState
    implements PublicDisplayUrlViewStateWithUrl {
  final PublicDisplayUrlEntity publicDisplayUrl;

  PublicDisplayUrlLoadFailureStateEmptyUri({required this.publicDisplayUrl});
}

final class PublicDisplayUrlLoadFailureStateWrongUri
    extends PublicDisplayUrlViewState
    implements PublicDisplayUrlViewStateWithUrl {
  final PublicDisplayUrlEntity publicDisplayUrl;

  PublicDisplayUrlLoadFailureStateWrongUri({required this.publicDisplayUrl});
}

final class PublicDisplayUrlViewStateWithUrl extends PublicDisplayUrlViewState {
  final PublicDisplayUrlEntity publicDisplayUrl;

  PublicDisplayUrlViewStateWithUrl({required this.publicDisplayUrl});
}
