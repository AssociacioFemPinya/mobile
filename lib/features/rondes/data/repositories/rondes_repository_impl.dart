import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

class RondesRepositoryImpl extends RondesRepository {
  @override
  Future<Either> getRondesList(GetRondesListParams params) async {
    return await sl<RondesService>().getRondesList(params);
  }

  @override
  Future<Either> getRonda(GetRondaParams params) async {
    return await sl<RondesService>().getRonda(params);
  }
}
