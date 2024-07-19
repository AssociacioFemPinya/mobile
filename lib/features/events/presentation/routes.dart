import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/pages/eventView/event_page.dart';
import 'package:flutter/widgets.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/pages/events_page.dart';

final Map<String, WidgetBuilder> eventsRoutes = {
  eventsRoute: (context) => const EventsPage(),
  eventRoute: (context) {
    //final event = ModalRoute.of(context)!.settings.arguments as EventEntity;
    final event = EventEntity(id: 1, title: "EventTitle", startDate: DateTime.parse('2024-07-01 02:00:00.000Z'), endDate: DateTime.parse('2024-07-01 02:00:00.000Z'), dateHour: '2024-07-01', address: "Some Address", status: EventStatusEnum.accepted, type: EventTypeEnum.activity);
    return EventPage(event: event);
  }
};
