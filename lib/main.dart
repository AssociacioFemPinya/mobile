import 'package:fempinya3_flutter_app/features/events/service_locator.dart';
import 'package:fempinya3_flutter_app/main_routes.dart';
import 'package:flutter/material.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:provider/provider.dart';
import 'package:fempinya3_flutter_app/features/menu/domain/entities/locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                routes: appRoutes,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: localeModel.locale,
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.system, //or ThemeMode.dark 
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
                initialRoute: eventsRoute,
              )),
    );
  }
}
