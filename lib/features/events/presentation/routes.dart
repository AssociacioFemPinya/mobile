import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/pages/event_page.dart';
import 'package:flutter/widgets.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/pages/events_page.dart';

final Map<String, WidgetBuilder> eventsRoutes = {
  eventsRoute: (context) => const EventsPage(),
  eventRoute: (context) {
    final event = ModalRoute.of(context)!.settings.arguments as EventEntity;
    return EventPage(event: event);
  }
};
