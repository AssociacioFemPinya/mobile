import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_events_list.dart';

abstract class EventsService {
  Future<Either> getEventsList(GetEventsListParams params);
}

class EventsServiceImpl implements EventsService {
  Future<Either> getEventsList(GetEventsListParams params) async {
    // TODO
    return const Right("");
  }
}
