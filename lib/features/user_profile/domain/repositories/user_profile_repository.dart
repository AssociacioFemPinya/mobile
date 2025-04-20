import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/user_profile/user_profile.dart';

abstract class UserProfileRepository {
  Future<Either> getUserProfile(GetUserProfileParams params);
}
