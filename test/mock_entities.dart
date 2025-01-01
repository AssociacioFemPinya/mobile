import 'package:fempinya3_flutter_app/features/login/login.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';
import 'package:fempinya3_flutter_app/features/login/presentation/bloc/authentication_bloc.dart';
import 'package:mockito/mockito.dart';

class MockRondesListBloc extends RondesListBloc {
  RondesListState state = RondesListInitial();

  void emit(RondesListState newState) {
    state = newState;
  }
}

class MockRondaViewBloc extends RondaViewBloc {
  RondaViewState state = RondaViewInitial();

  void emit(RondaViewState newState) {
    state = newState;
  }
}

class MockPublicDisplayUrlViewBloc extends PublicDisplayUrlViewBloc {
  PublicDisplayUrlViewState state = PublicDisplayUrlViewInitial();

  void emit(PublicDisplayUrlViewState newState) {
    state = newState;
  }

  MockPublicDisplayUrlViewBloc() : super();
}

class MockAuthenticationBloc extends AuthenticationBloc {
  final UserEntity _userEntity = UserEntity(
      mail: 'test@example.com', id: 0, name: "toto", password: "fifi");

  MockAuthenticationBloc({required super.authenticationRepository});

  @override
  AuthenticationState get state =>
      AuthenticationState.authenticated(_userEntity);

  UserEntity get userEntity => _userEntity;
}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}
