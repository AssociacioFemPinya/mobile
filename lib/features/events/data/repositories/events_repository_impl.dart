import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/events/data/sources/events_service.dart';
import 'package:fempinya3_flutter_app/features/events/domain/repositories/events_repository.dart';

import 'package:fempinya3_flutter_app/features/events/service_locator.dart';

class EventsRepositoryImpl extends EventsRepository {
  @override
  Future<Either> getEventsList() async {
    return await sl<EventsService>().getEventsList();
  }
}
