import 'package:fempinya3_flutter_app/core/service_locator.dart';
import 'package:fempinya3_flutter_app/features/events/service_locator.dart';
import 'package:fempinya3_flutter_app/features/login/login.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';
import 'package:fempinya3_flutter_app/main_routes.dart';
import 'package:fempinya3_flutter_app/features/menu/domain/entities/locale.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fempinya3_flutter_app/features/notifications/service_locator.dart';

void main() {
  setupCommonServiceLocator();
  setupEventsServiceLocator();
  setupLoginServiceLocator();
  setupRondesServiceLocator();
  setupNotificationsServiceLocator();
  runApp(const App());
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

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    authenticationBloc =
        AuthenticationBloc(authenticationRepository: _authenticationRepository);
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GoRouter router = appRouter(authenticationBloc);
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider.value(
        value: authenticationBloc..add(AuthenticationSubscriptionRequested()),
        child: MyApp(router: router),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.router,
  });

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleModel(),
      child: Consumer<LocaleModel>(
        builder: (context, localeModel, child) {
          return MaterialApp.router(
            title: 'FemPinya App',
            routerConfig: router, // Use the GoRouter configuration
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
          );
          // );
        },
      ),
    );
  }
}
