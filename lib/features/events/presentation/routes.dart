import 'package:fempinya3_flutter_app/features/events/presentation/pages/event_view/event_page.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/pages/events_list/events_list_page.dart';
import 'package:go_router/go_router.dart';


final List<GoRoute> eventRoutes = [
    GoRoute(
      path: eventsRoute,
      builder: (context, state) => const EventsListPage(),
    ),
    GoRoute(
      path: '$eventRoute/:eventID',
      builder: (context, state) {
        final eventID = int.parse(state.params['eventID']!);
        return EventPage(eventID: eventID);
      },
    ),
];