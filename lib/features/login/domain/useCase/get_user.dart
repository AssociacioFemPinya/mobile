import 'package:fempinya3_flutter_app/features/login/login.dart';
import 'package:fempinya3_flutter_app/core/usecase/usecase.dart';

import 'package:dartz/dartz.dart';

class GetUserParams {
  final String? mail;
  final String? password;

  GetUserParams({
    this.mail,
    this.password,
  });
}

class GetUser implements UseCase<Either, GetUserParams> {
  final UsersRepository repository = sl<UsersRepository>();

  @override
  Future<Either> call({required GetUserParams params}) async {
    return await repository.getUser(params);
  }
}
