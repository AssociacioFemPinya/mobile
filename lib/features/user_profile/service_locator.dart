import 'package:get_it/get_it.dart';

import 'package:fempinya3_flutter_app/features/user_profile/user_profile.dart';

final sl = GetIt.instance;

Future<void> setupUserProfileServiceLocator() async {
  // Important: Keep dio instance on top, otherwise services (which use dio) will get a get_it not found error
  sl.registerSingleton<UserProfileService>(UserProfileServiceImpl());
  sl.registerSingleton<UserProfileRepository>(UserProfileRepositoryImpl());
  sl.registerSingleton<GetUserProfile>(GetUserProfile());
}
