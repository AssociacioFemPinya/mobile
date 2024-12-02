import 'package:fempinya3_flutter_app/features/login/login.dart';

import 'package:dartz/dartz.dart';

abstract class UsersRepository {
  Future<Either> getUser(GetUserParams params);
}
