import 'package:flutter/material.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/home/presentation/routes.dart' as home_routes;
import 'package:fempinya3_flutter_app/features/events/presentation/routes.dart' as events_routes;
import 'package:fempinya3_flutter_app/features/notifications/presentation/routes.dart' as notifications_routes;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FemPinya App',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true
      ),
      initialRoute: homeRoute,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case homeRoute:
            return MaterialPageRoute(builder: (_) => home_routes.homeRoutes[homeRoute]!(context));
          case eventsRoute:
            return MaterialPageRoute(builder: (_) => events_routes.eventsRoutes[eventsRoute]!(context));
          case notificationsRoute:
            return MaterialPageRoute(builder: (_) => notifications_routes.notificationsRoutes[notificationsRoute]!(context));
          default:
            return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('Route not found'))));
        }
      },
    );
  }
}
