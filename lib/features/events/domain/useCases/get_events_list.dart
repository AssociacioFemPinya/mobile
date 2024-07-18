import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/core/usecase/usecase.dart';
import 'package:fempinya3_flutter_app/features/events/domain/repositories/events_repository.dart';

import 'package:fempinya3_flutter_app/features/events/service_locator.dart';

class GetEventsList implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<EventsRepository>().getEventsList();
  }
}
