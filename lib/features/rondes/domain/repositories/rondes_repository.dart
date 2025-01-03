import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

abstract class RondesRepository {
  Future<Either> getRondesList(GetRondesListParams params);
  Future<Either> getRonda(GetRondaParams params);
  Future<Either> getPublicDisplayUrl(GetPublicDisplayUrlParams params);
}
