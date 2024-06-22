import 'package:flutter/widgets.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/notifications/presentation/pages/notifications_page.dart';

final Map<String, WidgetBuilder> notificationsRoutes = {
  notificationsRoute: (context) => NotificationsPage(),
};
