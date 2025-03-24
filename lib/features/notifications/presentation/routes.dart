import 'package:fempinya3_flutter_app/features/notifications/presentation/pages/notification_view/notification_page.dart';
import 'package:go_router/go_router.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/notifications/presentation/pages/notifications_list/notifications_page.dart';

final List<GoRoute> notificationRoutes = [
  GoRoute(
    name: notificationsRoute,
    path: notificationsRoute,
    builder: (context, state) => const NotificationsPage(),
  ),
  GoRoute(
    name: notificationRoute,
    path: '$notificationRoute/:notificationID',
    builder: (context, state){
      print("YOOOOOO");
      print(state.pathParameters);
      final notificationID = int.parse(state.pathParameters['notificationID']!);
      return NotificationPage(notificationID: notificationID);
    },
  ),
];
