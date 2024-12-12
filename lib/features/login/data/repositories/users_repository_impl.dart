import 'package:fempinya3_flutter_app/features/login/login.dart';

import 'package:dartz/dartz.dart';

class UsersRepositoryImpl extends UsersRepository {
  @override
  Future<Either> getUser(GetUserParams params) async {
    return await sl<UsersService>().getUser(params);
  }
}
