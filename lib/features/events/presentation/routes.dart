import 'package:flutter/widgets.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/pages/events_page.dart';

final Map<String, WidgetBuilder> eventsRoutes = {
  eventsRoute: (context) => EventsPage(),
};
