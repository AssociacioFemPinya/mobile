import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/core/service_locator.dart';
import 'package:fempinya3_flutter_app/features/login/login.dart' hide sl;
import 'package:fempinya3_flutter_app/features/menu/domain/entities/locale.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart' hide sl;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart' hide ProgressCallback;
import 'mock_entities.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart'
    hide ProgressCallback;

void main() {
  late MockRondesListBloc mockRondesListBloc;
  late MockRondaViewBloc mockRondaViewBloc;
  late MockAuthenticationRepository mockAuthenticationRepository;
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockPublicDisplayUrlViewBloc mockPublicDisplayUrlViewBloc;

  setUp(() {
    mockRondesListBloc = MockRondesListBloc();
    mockRondaViewBloc = MockRondaViewBloc();
    mockAuthenticationRepository = MockAuthenticationRepository();
    mockAuthenticationBloc = MockAuthenticationBloc(
        authenticationRepository: mockAuthenticationRepository);
    mockPublicDisplayUrlViewBloc = MockPublicDisplayUrlViewBloc();
  });

  setUpAll(() {
    setupCommonServiceLocator();
    setupRondesServiceLocator();
    final Dio _dio = sl<Dio>();
    _dio.interceptors.clear();
    _dio.interceptors.add(RondesDioMockInterceptor());
    WebViewPlatform.instance = FakeWebViewPlatform();
  });

  group(RondesListBloc, () {
    late RondesListBloc rondesListBloc;

    setUp(() {
      rondesListBloc = RondesListBloc();
    });

    test('givenRondesListBloc_whenInit_thenStateIsInitial', () {
      expect(rondesListBloc.state, RondesListInitial());
    });

    blocTest<RondesListBloc, RondesListState>(
      'givenRondesListBloc_whenLoadRondesList_thenStateIsLoadSuccessAndRondes are retrieved',
      build: () => rondesListBloc,
      act: (bloc) => bloc.add(LoadRondesList()),
      wait: const Duration(milliseconds: 200),
      expect: () => <RondesListState>[
        RondesListLoadSuccessState(List.empty()),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<RondesListLoadSuccessState>());
        expect((bloc.state as RondesListLoadSuccessState).rondes, hasLength(4));
        expect(
            (bloc.state as RondesListLoadSuccessState).rondes,
            contains(RondaEntity(
                id: 0,
                publicUrl:
                    'https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==',
                ronda: 0,
                name: 'Lorem ipsum dolor')));
        expect(
            (bloc.state as RondesListLoadSuccessState).rondes,
            contains(RondaEntity(
                id: 1,
                publicUrl:
                    'https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==',
                ronda: 1,
                name: 'Lorem ipsum dolor')));
        expect(
            (bloc.state as RondesListLoadSuccessState).rondes,
            contains(RondaEntity(
                id: 2, publicUrl: '', ronda: 2, name: 'sit amet.')));
        expect(
            (bloc.state as RondesListLoadSuccessState).rondes,
            contains(RondaEntity(
                id: 3,
                publicUrl: 'mail@mail.com',
                ronda: 3,
                name: 'Sed quisquam')));
        final event = LoadRondesList();
        expect(event.toString(),
            'Rondes button pressed');
      },
    );
  });

  group(RondaViewBloc, () {
    late RondaViewBloc rondaViewBloc;

    setUp(() {
      rondaViewBloc = RondaViewBloc();
    });

    test('givenRondaViewBloc_whenInit_thenStateIsInitial', () {
      expect(rondaViewBloc.state, RondaViewInitial());
    });

    blocTest<RondaViewBloc, RondaViewState>(
      'givenRondaViewBloc_whenRondaLoadEvent_thenStateIsLoadSuccessAndRonda is retrieved',
      build: () => RondaViewBloc(),
      act: (bloc) => bloc.add(RondaLoadEvent(id: 0)),
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        expect(bloc.state, isA<RondaViewLoadSuccessState>());
        expect(
            (bloc.state as RondaViewLoadSuccessState).ronda,
            equals(RondaEntity(
                id: 0,
                publicUrl:
                    'https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==',
                ronda: 0,
                name: 'Lorem ipsum dolor')));
      },
    );

    blocTest<RondaViewBloc, RondaViewState>(
      'givenRondaViewBloc_whenRondaLoadEventWithUnknownId_thenStateIsFailureStateAndMsgIsCorrect',
      build: () => RondaViewBloc(),
      act: (bloc) => bloc.add(RondaLoadEvent(id: 100)),
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        expect(bloc.state, isA<RondaViewLoadFailureState>());
        expect((bloc.state as RondaViewLoadFailureState).failure,
            equals('Unknown ronda id'));
      },
    );

    blocTest<RondaViewBloc, RondaViewState>(
      'givenRondaViewBloc_whenRondaLoadEventWithoutURL_thenStateIsFailureStateAndMsgIsCorrect',
      build: () => RondaViewBloc(),
      act: (bloc) => bloc.add(RondaLoadEvent(id: 2)),
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        expect(bloc.state, isA<RondaViewLoadFailureStateEmptyUri>());
      },
    );

    blocTest<RondaViewBloc, RondaViewState>(
      'givenRondaViewBloc_whenRondaLoadEventWithWrongURL_thenStateIsFailureStateAndMsgIsCorrect',
      build: () => RondaViewBloc(),
      act: (bloc) => bloc.add(RondaLoadEvent(id: 3)),
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        expect(bloc.state, isA<RondaViewLoadFailureStateWrongUri>());
      },
    );
  });

  group('RondesListPage', () {
    testWidgets('should render the page', (tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<RondesListBloc>(
              create: (context) => mockRondesListBloc,
            ),
            BlocProvider<AuthenticationBloc>(
              create: (context) => mockAuthenticationBloc,
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ChangeNotifierProvider<LocaleModel>(
              create: (_) => LocaleModel(),
              child: RondesListPage(),
            ),
          ),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Drawer),
          findsNothing); // Expect the drawer to not be found initially

      // Simulate the user opening the drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();

      expect(find.byType(Drawer),
          findsOneWidget); // Expect the drawer to be found after opening

      await tester.pumpAndSettle();

      // Dispose of the timer
      await tester.pump(Duration.zero);
    });

    testWidgets('should render the list of rondes', (tester) async {
      mockRondesListBloc.state = RondesListLoadSuccessState(
        [
          RondaEntity(id: 1, ronda: 1, name: 'Event 1', publicUrl: ''),
          RondaEntity(id: 2, ronda: 2, name: 'Event 2', publicUrl: ''),
        ],
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<RondesListBloc>(
              create: (context) => mockRondesListBloc,
            ),
            BlocProvider<AuthenticationBloc>(
              create: (context) => mockAuthenticationBloc,
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ChangeNotifierProvider<LocaleModel>(
              create: (_) => LocaleModel(),
              child: RondesListPageContents(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('should navigate to the ronda page', (tester) async {
      mockRondesListBloc.state = RondesListLoadSuccessState(
        [
          RondaEntity(id: 1, ronda: 1, name: 'Event 1', publicUrl: ''),
        ],
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<RondesListBloc>(
              create: (context) => mockRondesListBloc,
            ),
            BlocProvider<AuthenticationBloc>(
              create: (context) => mockAuthenticationBloc,
            ),
          ],
          child: MaterialApp.router(
            locale: Locale('ca'),
            routerConfig: GoRouter(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) =>
                      ChangeNotifierProvider<LocaleModel>(
                          create: (_) => LocaleModel(),
                          child: BlocProvider<MockRondesListBloc>(
                            create: (context) => mockRondesListBloc,
                            child: RondesListPageContents(),
                          )),
                ),
                GoRoute(
                  name: "ronda",
                  path: '/ronda/:rondaID',
                  builder: (context, state) =>
                      Container(), // Mock RondaPage with Container
                ),
              ],
              initialLocation: '/',
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );

      await tester.pump();
      expect(find.text('Ronda 1 Event 1'), findsOneWidget);
      await tester.press(find.byType(ElevatedButton));
    });
  });
  group('RondaPage', () {
    testWidgets(
        'should display CircularProgressIndicator when state is RondaViewInitial',
        (tester) async {
      // Arrange
      mockRondaViewBloc.state = RondaViewInitial();

      // Act
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<RondaViewBloc>(
              create: (context) => mockRondaViewBloc,
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ChangeNotifierProvider<LocaleModel>(
              create: (_) => LocaleModel(),
              child: RondaViewContentsPage(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('AppBar title is correct when RondaViewLoadSuccessState',
        (tester) async {
      // Arrange
      final ronda = RondaEntity(
          id: 1,
          ronda: 1,
          name: 'Test Event',
          publicUrl:
              'https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==');
      mockRondaViewBloc.state = RondaViewLoadSuccessState(ronda: ronda);

      // Act
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<RondaViewBloc>(
              create: (context) => mockRondaViewBloc,
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ChangeNotifierProvider<LocaleModel>(
              create: (_) => LocaleModel(),
              child: RondaViewContentsPage(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Ronda 1 Test Event'), findsOneWidget);
    });

    testWidgets('Error is correct when url is empty', (tester) async {
      // Arrange
      final ronda =
          RondaEntity(id: 1, ronda: 1, name: 'Test Event', publicUrl: '');
      mockRondaViewBloc.state = RondaViewLoadFailureStateEmptyUri(ronda: ronda);

      // Act
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<RondaViewBloc>(
              create: (context) => mockRondaViewBloc,
            ),
          ],
          child: MaterialApp(
            locale: Locale('ca'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ChangeNotifierProvider<LocaleModel>(
              create: (_) => LocaleModel(),
              child: RondaViewContentsPage(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Ronda URI està vuida'), findsOneWidget);
    });

    testWidgets('Error is correct when url is wrong', (tester) async {
      // Arrange
      final ronda = RondaEntity(
          id: 1, ronda: 1, name: 'Test Event', publicUrl: 'mail@mail.com');
      mockRondaViewBloc.state = RondaViewLoadFailureStateWrongUri(ronda: ronda);

      // Act
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<RondaViewBloc>(
              create: (context) => mockRondaViewBloc,
            ),
          ],
          child: MaterialApp(
            locale: Locale('ca'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ChangeNotifierProvider<LocaleModel>(
              create: (_) => LocaleModel(),
              child: RondaViewContentsPage(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Ronda URI incorrecta'), findsOneWidget);
    });
  });
  group('Rondes Routes', () {
    testWidgets('Rondes List Page route', (tester) async {
      await tester.pumpWidget(
        BlocProvider<AuthenticationBloc>(
          create: (context) => mockAuthenticationBloc,
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: rondesRoutes,
              initialLocation: rondesRoute,
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );

      expect(find.byType(RondesListPage), findsOneWidget);

      await tester.pump(Duration(seconds: 10));
      await tester.tap(find.byType(ElevatedButton).first);
    });

    testWidgets('Ronda Page route', (tester) async {
      await tester.pumpWidget(
        BlocProvider<AuthenticationBloc>(
          create: (context) => mockAuthenticationBloc,
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: rondesRoutes,
              initialLocation: '$rondaRoute/0',
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );

      await tester.pump(Duration(seconds: 10));
      expect(find.byType(RondaPage), findsOneWidget);

      expect(find.byType(MyWebView), findsOneWidget);
      final webView = tester.firstWidget(find.byType(MyWebView));
      expect((webView as MyWebView).url,
          'https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==');
    });

    testWidgets('PublicDisplayUrl Page route', (tester) async {
      await tester.pumpWidget(
        BlocProvider<AuthenticationBloc>(
          create: (context) => mockAuthenticationBloc,
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: rondesRoutes,
              initialLocation: publicDisplayUrlRoute,
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );

      await tester.pump(Duration(seconds: 2));
      expect(find.byType(PublicDisplayUrlPage), findsOneWidget);
      
    });
  });
  group('PublicDisplayUrlViewBloc', () {
    late PublicDisplayUrlViewBloc publicDisplayUrlViewBloc;

    setUp(() {
      publicDisplayUrlViewBloc = PublicDisplayUrlViewBloc();
    });

    test('givenPublicDisplayUrlViewBloc_whenInit_thenStateIsInitial', () {
      expect(publicDisplayUrlViewBloc.state, PublicDisplayUrlViewInitial());
    });

    blocTest<PublicDisplayUrlViewBloc, PublicDisplayUrlViewState>(
      'givenPublicDisplayUrlViewBloc_whenPublicDisplayUrlLoadEvent_thenStateIsLoadSuccessAndPublicDisplayUrlIsRetrieved',
      build: () => publicDisplayUrlViewBloc,
      act: (bloc) =>
          bloc.add(PublicDisplayUrlLoadEvent(email: 'mail@mail.com')),
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        expect(bloc.state, isA<PublicDisplayUrlLoadSuccessState>());
        expect(
            (bloc.state as PublicDisplayUrlLoadSuccessState).publicDisplayUrl,
            equals(PublicDisplayUrlEntity(
              publicUrl:
                  'https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==',
            )));
      },
    );
    blocTest<PublicDisplayUrlViewBloc, PublicDisplayUrlViewState>(
      'givenPublicDisplayUrlViewBloc_whenPublicDisplayUrlLoadEventWithUnknownMail_thenStateIsFailureStateAndMsgIsCorrect',
      build: () => publicDisplayUrlViewBloc,
      act: (bloc) =>
          bloc.add(PublicDisplayUrlLoadEvent(email: 'toto@toto.com')),
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        expect(bloc.state, isA<PublicDisplayUrlLoadFailureState>());
        expect((bloc.state as PublicDisplayUrlLoadFailureState).failure,
            equals('Unknown email'));
      },
    );

    blocTest<PublicDisplayUrlViewBloc, PublicDisplayUrlViewState>(
      'givenPublicDisplayUrlViewBloc_whenPublicDisplayUrlLoadEventWithCorrectMailWithoutPublicUrl_thenStateIsFailureStateAndMsgIsCorrect',
      build: () => publicDisplayUrlViewBloc,
      act: (bloc) =>
          bloc.add(PublicDisplayUrlLoadEvent(email: 'emptyUrl@mail.com')),
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        expect(bloc.state, isA<PublicDisplayUrlLoadFailureStateEmptyUri>());
        expect(
            (bloc.state as PublicDisplayUrlLoadFailureStateEmptyUri)
                .publicDisplayUrl
                .publicUrl,
            '');
      },
    );

    blocTest<PublicDisplayUrlViewBloc, PublicDisplayUrlViewState>(
      'givenPublicDisplayUrlViewBloc_whenPublicDisplayUrlLoadEventWithCorrectMailWithWrongPublicUrl_thenStateIsPublicDisplayUrlLoadFailureStateWrongUri',
      build: () => publicDisplayUrlViewBloc,
      act: (bloc) =>
          bloc.add(PublicDisplayUrlLoadEvent(email: 'wrongUrl@mail.com')),
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        expect(bloc.state, isA<PublicDisplayUrlLoadFailureStateWrongUri>());
      },
    );
  });

  group('PublicDisplayUrlPage', () {
    testWidgets(
        'should display CircularProgressIndicator when state is PublicDisplayUrlViewInitial',
        (tester) async {
      // Arrange
      mockPublicDisplayUrlViewBloc.state = PublicDisplayUrlViewInitial();

      // Act
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<PublicDisplayUrlViewBloc>(
              create: (context) => mockPublicDisplayUrlViewBloc,
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ChangeNotifierProvider<LocaleModel>(
              create: (_) => LocaleModel(),
              child: PublicDisplayUrlViewContentsPage(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'givenCorrectPublicDisplayUrl_whenPublicDisplayUrlLoadSuccessState_thenWebViewIsDisplayed',
        (tester) async {
      PublicDisplayUrlEntity publicDisplayUrl =
          PublicDisplayUrlEntity(publicUrl: 'https://www.google.com');
      // Arrange
      mockPublicDisplayUrlViewBloc.state =
          PublicDisplayUrlLoadSuccessState(publicDisplayUrl: publicDisplayUrl);

      // Act
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<PublicDisplayUrlViewBloc>(
              create: (context) => mockPublicDisplayUrlViewBloc,
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ChangeNotifierProvider<LocaleModel>(
              create: (_) => LocaleModel(),
              child: PublicDisplayUrlViewContentsPage(),
            ),
          ),
        ),
      );

      // Assert
      final appBar = tester.firstWidget(find.byType(AppBar));
      expect((appBar as AppBar).title, isNotNull);
      expect(appBar.title, isA<Text>());
      expect((appBar.title as Text).data, 'Pinya');

      expect(find.byType(MyWebView), findsOneWidget);
      final webView = tester.firstWidget(find.byType(MyWebView));
      expect((webView as MyWebView).url, 'https://www.google.com');
    });

    testWidgets(
        'givenWrongPublicDisplayUrl_whenPublicDisplayUrlLoadSuccessState_thenWebViewIsDisplayed',
        (tester) async {
      PublicDisplayUrlEntity publicDisplayUrl =
          PublicDisplayUrlEntity(publicUrl: 'wrong url');
      // Arrange
      mockPublicDisplayUrlViewBloc.state =
          PublicDisplayUrlLoadFailureStateWrongUri(
              publicDisplayUrl: publicDisplayUrl);

      // Act
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<PublicDisplayUrlViewBloc>(
              create: (context) => mockPublicDisplayUrlViewBloc,
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ChangeNotifierProvider<LocaleModel>(
              create: (_) => LocaleModel(),
              child: PublicDisplayUrlViewContentsPage(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('URI pinya projectada incorrecta'), findsOneWidget);
    });

    testWidgets(
        'givenEmptyPublicDisplayUrl_whenPublicDisplayUrlLoadSuccessState_thenWebViewIsDisplayed',
        (tester) async {
      PublicDisplayUrlEntity publicDisplayUrl =
          PublicDisplayUrlEntity(publicUrl: '');
      // Arrange
      mockPublicDisplayUrlViewBloc.state =
          PublicDisplayUrlLoadFailureStateEmptyUri(
              publicDisplayUrl: publicDisplayUrl);

      // Act
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<PublicDisplayUrlViewBloc>(
              create: (context) => mockPublicDisplayUrlViewBloc,
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ChangeNotifierProvider<LocaleModel>(
              create: (_) => LocaleModel(),
              child: PublicDisplayUrlViewContentsPage(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Cap pinya projectada'), findsOneWidget);
    });
  });
}

class FakeWebViewPlatform extends WebViewPlatform {
  @override
  PlatformWebViewController createPlatformWebViewController(
    PlatformWebViewControllerCreationParams params,
  ) {
    return FakeWebViewController(params);
  }

  @override
  PlatformWebViewWidget createPlatformWebViewWidget(
    PlatformWebViewWidgetCreationParams params,
  ) {
    return FakeWebViewWidget(params);
  }

  @override
  PlatformWebViewCookieManager createPlatformCookieManager(
    PlatformWebViewCookieManagerCreationParams params,
  ) {
    return FakeCookieManager(params);
  }

  @override
  PlatformNavigationDelegate createPlatformNavigationDelegate(
    PlatformNavigationDelegateCreationParams params,
  ) {
    return FakeNavigationDelegate(params);
  }
}

class FakeWebViewController extends PlatformWebViewController {
  FakeWebViewController(super.params) : super.implementation();

  @override
  Future<void> setJavaScriptMode(JavaScriptMode javaScriptMode) async {}

  @override
  Future<void> setBackgroundColor(Color color) async {}

  @override
  Future<void> setPlatformNavigationDelegate(
    PlatformNavigationDelegate handler,
  ) async {}

  @override
  Future<void> addJavaScriptChannel(
      JavaScriptChannelParams javaScriptChannelParams) async {}

  @override
  Future<void> loadRequest(LoadRequestParams params) async {}

  @override
  Future<String?> currentUrl() async {
    return 'https://www.google.com';
  }
}

class FakeCookieManager extends PlatformWebViewCookieManager {
  FakeCookieManager(super.params) : super.implementation();
}

class FakeWebViewWidget extends PlatformWebViewWidget {
  FakeWebViewWidget(super.params) : super.implementation();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FakeNavigationDelegate extends PlatformNavigationDelegate {
  FakeNavigationDelegate(super.params) : super.implementation();

  @override
  Future<void> setOnNavigationRequest(
    NavigationRequestCallback onNavigationRequest,
  ) async {}

  @override
  Future<void> setOnPageFinished(PageEventCallback onPageFinished) async {}

  @override
  Future<void> setOnPageStarted(PageEventCallback onPageStarted) async {}

  @override
  Future<void> setOnProgress(void Function(int) onProgress) async {}

  @override
  Future<void> setOnWebResourceError(
    WebResourceErrorCallback onWebResourceError,
  ) async {}
}
