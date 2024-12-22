import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/post_event.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/core/network/dio_factory.dart';
import 'package:fempinya3_flutter_app/features/events/data/repositories/events_repository_impl.dart';
import 'package:fempinya3_flutter_app/features/events/data/sources/events_service.dart';
import 'package:fempinya3_flutter_app/features/events/domain/repositories/events_repository.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_events_list.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupEventsServiceLocator() async {
  sl.registerSingleton<EventsService>(EventsServiceImpl());
  sl.registerSingleton<EventsRepository>(EventsRepositoryImpl());
  sl.registerSingleton<GetEventsList>(GetEventsList());
  sl.registerSingleton<GetEvent>(GetEvent());
  sl.registerSingleton<PostEvent>(PostEvent());
}
