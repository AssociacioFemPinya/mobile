import 'package:dartz/dartz.dart';

import 'package:fempinya3_flutter_app/core/usecase/usecase.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

class GetRondaParams {
  final int? id;

  GetRondaParams({
    this.id,
  });
}

class GetRonda implements UseCase<Either, GetRondaParams> {
  final RondesRepository repository = sl<RondesRepository>();

  @override
  Future<Either> call({required GetRondaParams params}) async {
    return await repository.getRonda(params);
  }
}
