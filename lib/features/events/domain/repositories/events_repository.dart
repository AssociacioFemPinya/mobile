import 'package:dartz/dartz.dart';

abstract class EventsRepository {
  Future<Either> getEventsList();
}
