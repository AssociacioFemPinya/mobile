import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_events_list.dart';


abstract class EventsRepository {
  Future<Either> getEventsList(GetEventsListParams params);
}
