import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/user_profile/user_profile.dart';

class UserProfileRepositoryImpl extends UserProfileRepository {
  @override
  Future<Either> getUserProfile(GetUserProfileParams params) async {
    return await sl<UserProfileService>().getUserProfile(params);
  }
}
