// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:fempinya3_flutter_app/core/global_theme.dart';
import 'package:fempinya3_flutter_app/features/events/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/home/presentation/routes.dart'
    as home_routes;
import 'package:fempinya3_flutter_app/features/events/presentation/routes.dart'
    as events_routes;
import 'package:fempinya3_flutter_app/features/notifications/presentation/routes.dart'
    as notifications_routes;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:fempinya3_flutter_app/features/menu/domain/entities/locale.dart';

void main() {
  setupEventsServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleModel(),
      child: Consumer<LocaleModel>(
          builder: (context, localeModel, child) => MaterialApp(
                title: 'FemPinya App',
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: localeModel.locale,
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.system, //or ThemeMode.dark 
                //theme: GlobalThemeData.lightThemeData,
                //darkTheme: GlobalThemeData.darkThemeData,
                //To-do Zan

                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.blue,
                    brightness: Brightness.light,
                    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
                  ),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.blue,
                    brightness: Brightness.dark,
                    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
                  ),
                  useMaterial3: true,
                ),
                initialRoute: homeRoute,
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case homeRoute:
                      //return MaterialPageRoute(builder: (_) => home_routes.homeRoutes[homeRoute]!(context));
                      return MaterialPageRoute(
                          builder: (_) => events_routes
                              .eventsRoutes[eventsRoute]!(context));
                    case eventsRoute:
                      return MaterialPageRoute(
                          builder: (_) => events_routes
                              .eventsRoutes[eventsRoute]!(context));
                    case notificationsRoute:
                      return MaterialPageRoute(
                          builder: (_) => notifications_routes
                                  .notificationsRoutes[notificationsRoute]!(
                              context));
                    default:
                      return MaterialPageRoute(
                          builder: (_) => const Scaffold(
                              body: Center(child: Text('Route not found'))));
                  }
                },
              )),
    );
  }
}
