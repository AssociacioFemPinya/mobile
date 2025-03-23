import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/routes.dart';
import 'package:fempinya3_flutter_app/features/home/presentation/pages/home_page.dart';
import 'package:fempinya3_flutter_app/features/login/login.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';
import 'package:fempinya3_flutter_app/features/notifications/presentation/routes.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

GoRouter appRouter(AuthenticationBloc authenticationBloc) {
  return GoRouter(
    initialLocation: eventsRoute,
    routes: [
      GoRoute(
        path: homeRoute,
        builder: (context, state) => HomePage(),
      ),
      ...eventRoutes,
      ...loginRoutes,
      ...rondesRoutes,
      ...notificationRoutes
    ],
    // changes on the listenable will cause the router to refresh it's route
    refreshListenable: StreamToListenable([authenticationBloc.stream]),
    //The top-level callback allows the app to redirect to a new location.
    redirect: (context, state) {
      final isAuthenticated =
          (authenticationBloc.state != const AuthenticationState.unknown() &&
              authenticationBloc.state !=
                  const AuthenticationState.unauthenticated());

      if (isAuthenticated) {
        // If the user is authenticated, redirect to the home page
        if (state.matchedLocation == loginRoute) {
          return eventsRoute;
        }
      } else if (isAuthenticated == false) {
        // If the user is not authenticated, redirect to the login page
        if (state.matchedLocation != loginRoute) {
          return eventsRoute;
        }
      }
      // Otherwise do not modify the route
      return null;
    },
  );
}

// convert authenticationBloc stream to listenable
// due to GoRouter configuration requirements.
class StreamToListenable extends ChangeNotifier {
  late final List<StreamSubscription> subscriptions;

  StreamToListenable(List<Stream> streams) {
    subscriptions = [];
    for (var e in streams) {
      var s = e.asBroadcastStream().listen(_tt);
      subscriptions.add(s);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (var e in subscriptions) {
      e.cancel();
    }
    super.dispose();
  }

  void _tt(event) => notifyListeners();
}
