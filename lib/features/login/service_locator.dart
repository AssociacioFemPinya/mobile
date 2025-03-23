import 'package:fempinya3_flutter_app/features/login/login.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupLoginServiceLocator() async {
  sl.registerSingleton<UsersService>(UsersServiceImpl());
  sl.registerSingleton<UsersRepository>(UsersRepositoryImpl());
  sl.registerSingleton<GetUser>(GetUser());
  sl.registerSingleton<GetToken>(GetToken());
}
