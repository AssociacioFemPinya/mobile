import 'package:go_router/go_router.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/notifications/presentation/pages/notifications_page.dart';

final List<GoRoute> notificationRoutes = [
  GoRoute(
    name: notificationsRoute,
    path: notificationsRoute,
    builder: (context, state) => const NotificationsPage(),
  ),
];
