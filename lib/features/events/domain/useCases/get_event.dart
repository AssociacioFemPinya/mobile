import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/core/usecase/usecase.dart';
import 'package:fempinya3_flutter_app/features/events/domain/repositories/events_repository.dart';

import 'package:fempinya3_flutter_app/features/events/service_locator.dart';


class GetEventParams {
  final int? id;

  GetEventParams({
    this.id,
  });
}

class GetEventsList implements UseCase<Either, GetEventParams> {
  final EventsRepository repository = sl<EventsRepository>();

  @override
  Future<Either> call({required GetEventParams params}) async {
    return await repository.getEvent(params);
  }
}
