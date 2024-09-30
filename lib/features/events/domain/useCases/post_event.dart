import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/core/usecase/usecase.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/repositories/events_repository.dart';

import 'package:fempinya3_flutter_app/features/events/service_locator.dart';


class PostEvent implements UseCase<Either, EventEntity> {
  final EventsRepository repository = sl<EventsRepository>();

  @override
  Future<Either> call({required EventEntity params}) async {
    return await repository.postEvent(params);
  }
}
