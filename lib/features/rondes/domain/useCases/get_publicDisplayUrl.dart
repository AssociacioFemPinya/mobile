import 'package:dartz/dartz.dart';

import 'package:fempinya3_flutter_app/core/usecase/usecase.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

class GetPublicDisplayUrlParams {

  GetPublicDisplayUrlParams();
}

class GetPublicDisplayUrl
    implements UseCase<Either, GetPublicDisplayUrlParams> {
  final RondesRepository repository = sl<RondesRepository>();

  @override
  Future<Either> call({required GetPublicDisplayUrlParams params}) async {
    return await repository.getPublicDisplayUrl(params);
  }
}
