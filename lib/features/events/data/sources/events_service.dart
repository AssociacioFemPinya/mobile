import 'package:dartz/dartz.dart';

abstract class EventsService {
  Future<Either> getEventsList();
}

class EventsServiceImpl implements EventsService {
  Future<Either> getEventsList() async {
    // TODO
    return const Right("");
  }
}
