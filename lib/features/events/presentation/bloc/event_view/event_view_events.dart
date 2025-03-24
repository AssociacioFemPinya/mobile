part of 'event_view_bloc.dart';

abstract class EventViewEvents {}

class LoadEvent extends EventViewEvents {
  final int value;
  LoadEvent(this.value);
}

class EventLoadSuccess extends EventViewEvents {
  final EventEntity value;
  EventLoadSuccess(this.value);
}

class EventLoadFailure extends EventViewEvents {
  final String value;
  EventLoadFailure(this.value);
}

class EventStatusModified extends EventViewEvents {
  final EventStatusEnum value;
  EventStatusModified(this.value);
}

class EventCompanionsModified extends EventViewEvents {
  final int value;
  EventCompanionsModified(this.value);
}

class EvenTagModified extends EventViewEvents {
  final String value;
  EvenTagModified(this.value);
}

class UpdateEvent extends EventViewEvents {
  final EventEntity value;
  UpdateEvent(this.value);
}

class EventUpdateSuccess extends EventViewEvents {
  final EventEntity value;
  EventUpdateSuccess(this.value);
}

class EventUpdateFailure extends EventViewEvents {
  final String value;
  EventUpdateFailure(this.value);
}

class AddEventComment extends EventViewEvents {
  final String value;
  AddEventComment(this.value);
}

class RemoveEventComment extends EventViewEvents {
  RemoveEventComment();
}
