import 'package:fempinya3_flutter_app/features/events/data/sources/events_service.dart';
import 'package:fempinya3_flutter_app/features/events/data/sources/events_service_mockup.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_events_list.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
 sl.registerSingleton<EventsService>(
  EventsServiceMockupImpl()
 );
 sl.registerSingleton<GetEventsList>(
  GetEventsList()
 );
}
