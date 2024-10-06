import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/routes.dart';
import 'package:fempinya3_flutter_app/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: eventsRoute,
  routes: [
    GoRoute(
      path: homeRoute,
      builder: (context, state) => HomePage(),
    ),
    ...eventRoutes,
  ],
);
