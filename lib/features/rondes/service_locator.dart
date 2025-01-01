import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupRondesServiceLocator() async {
  // Important: Keep dio instance on top, otherwise services (which use dio) will get a get_it not found error
  sl.registerSingleton<RondesService>(RondesServiceImpl());
  sl.registerSingleton<RondesRepository>(RondesRepositoryImpl());
  sl.registerSingleton<GetRondesList>(GetRondesList());
  sl.registerSingleton<GetRonda>(GetRonda());
  sl.registerSingleton<GetPublicDisplayUrl>(GetPublicDisplayUrl());
}
