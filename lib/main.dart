import 'package:fempinya3_flutter_app/features/events/service_locator.dart';
import 'package:fempinya3_flutter_app/main_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fempinya3_flutter_app/features/menu/domain/entities/locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  setupEventsServiceLocator();
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleModel(),
      child: Consumer<LocaleModel>(
        builder: (context, localeModel, child) => MaterialApp.router(
          title: 'FemPinya App',
          routerConfig: appRouter, // Use the GoRouter configuration
          builder: EasyLoading.init(),
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
              seedColor: Colors.orangeAccent,
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
        ),
      ),
    );
  }
}
