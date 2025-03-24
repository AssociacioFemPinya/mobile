import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/core/usecase/usecase.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

class GetRondesListParams {

  GetRondesListParams();
}

class GetRondesList implements UseCase<Either, GetRondesListParams> {
  final RondesRepository repository = sl<RondesRepository>();

  @override
  Future<Either> call({required GetRondesListParams params}) async {
    return await repository.getRondesList(params);
  }
}
