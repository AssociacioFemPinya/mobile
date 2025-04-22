import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/core/service_locator.dart';
import 'package:fempinya3_flutter_app/features/menu/domain/entities/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rxdart/rxdart.dart';

import 'package:fempinya3_flutter_app/features/user_profile/user_profile.dart'
    hide sl;
import 'package:provider/provider.dart';

class MockGetUserProfile extends Mock implements GetUserProfile {}

class MockUserProfileViewBloc
    extends MockBloc<UserProfileViewEvent, UserProfileViewState>
    implements UserProfileViewBloc {}

void main() {
  // Real instance of user profile
  GetUserProfile? _getUserProfile;
  // Real instance of dio
  Dio? _dio;

  setUpAll(() {
    setupCommonServiceLocator();
    setupUserProfileServiceLocator(true);
    _dio = sl<Dio>();
    _dio!.interceptors.clear();
    _dio!.interceptors.add(UserProfileDioMockInterceptor());
    //Save real instance
    _getUserProfile = sl<GetUserProfile>();
  });
  group('UserProfileViewBloc', () {
    late MockGetUserProfile mockGetUserProfile;
    late UserProfileViewBloc userProfileViewBloc;

    setUp(() {
      // Register fallback mocktail calls
      registerFallbackValue(GetUserProfileParams());
      // Unregister the existing GetUserProfile instance
      sl.unregister<GetUserProfile>();
      // Register the mock Logger instance
      mockGetUserProfile = MockGetUserProfile();
      sl.registerSingleton<GetUserProfile>(mockGetUserProfile);
      // Init bloc
      userProfileViewBloc = UserProfileViewBloc();
    });

    tearDown(() {
      // Unregister the mock instances after the test
      sl.unregister<GetUserProfile>();
      // Register real instance to continue the tests
      sl.registerSingleton<GetUserProfile>(_getUserProfile!);
      // Reset mock
      reset(mockGetUserProfile);
      // Close bloc
      userProfileViewBloc.close();
    });

    test('LoadUser events with same properties are equal', () {
      final event1 = const LoadUserProfile();
      final event2 = const LoadUserProfile();

      expect(event1, equals(event2));
      expect(event1.hashCode, equals(event2.hashCode));
    });

    test('initial state is UserProfileViewInitial', () {
      expect(userProfileViewBloc.state, UserProfileViewInitial());
    });

    blocTest<UserProfileViewBloc, UserProfileViewState>(
      'emits [UserLoadInProgress, UserLoadSuccess] when LoadUser is added and successful',
      build: () {
        when(() => mockGetUserProfile.call(params: any(named: 'params')))
            .thenAnswer((_) async => Right(UserProfileEntity(
                  idCasteller: 1,
                  idCastellerExternal: 1234,
                  collaId: 1,
                  numSoci: 'S001',
                  alias: 'TestUser',
                  gender: 1,
                  email: 'test@example.com',
                  email2: 'test2@example.com',
                  phone: '123456789',
                  height: 170,
                  weight: 70,
                  status: 1,
                  interactionType: 1,
                  createdAt: '2023-01-01T00:00:00.000Z',
                  updatedAt: '2023-01-01T00:00:00.000Z',
                )));
        return userProfileViewBloc;
      },
      act: (bloc) => bloc.add(const LoadUserProfile()),
      expect: () => [
        UserProfileLoadInProgress(),
        UserProfileLoadSuccess(UserProfileEntity(
          idCasteller: 1,
          idCastellerExternal: 1234,
          collaId: 1,
          numSoci: 'S001',
          alias: 'TestUser',
          gender: 1,
          email: 'test@example.com',
          email2: 'test2@example.com',
          phone: '123456789',
          height: 170,
          weight: 70,
          status: 1,
          interactionType: 1,
          createdAt: '2023-01-01T00:00:00.000Z',
          updatedAt: '2023-01-01T00:00:00.000Z',
        )),
      ],
      verify: (_) {
        verify(() => mockGetUserProfile.call(params: any(named: 'params')))
            .called(1);
      },
    );

    blocTest<UserProfileViewBloc, UserProfileViewState>(
      'emits [UserProfileLoadInProgress, UserProfileLoadFailure] when LoadUserProfile is added and fails',
      build: () {
        when(() => mockGetUserProfile.call(params: any(named: 'params')))
            .thenAnswer((_) async => const Left('Error fetching user profile'));
        return userProfileViewBloc;
      },
      act: (bloc) => bloc.add(const LoadUserProfile()),
      expect: () => [
        UserProfileLoadInProgress(),
        const UserProfileLoadFailure('Error fetching user profile'),
      ],
      verify: (_) {
        verify(() => mockGetUserProfile.call(params: any(named: 'params')))
            .called(1);
      },
    );
  });

  group('UserProfilePage Tests', () {
    late MockUserProfileViewBloc mockBloc;

    setUp(() {
      mockBloc = MockUserProfileViewBloc();
    });

    testWidgets(
        'should display loading indicator when state is UserProfileLoadInProgress',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp.router(
            routerConfig: GoRouter(
              routes: userProfileRoutes,
              initialLocation: userProfileRoute,
            ),
            localizationsDelegates: [
              AppLocalizations.delegate,
            ],
            builder: EasyLoading.init()),
      );

      // Ensure the widget tree is built
      await tester.pump(Duration(seconds: 2));

      // Assert
      // Verify that the Center widget is present
      expect(find.byType(Center), findsWidgets);
      // Verify that the Text widget is present
      expect(find.byType(Text), findsWidgets);

      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('should display user profile when state is UserLoadSuccess',
        (WidgetTester tester) async {
      // Arrange
      final userProfile = UserProfileEntity(
        idCasteller: 1,
        idCastellerExternal: 1234,
        collaId: 1,
        numSoci: 'S001',
        gender: 1,
        alias: 'TestUser',
        email: 'test@example.com',
        email2: 'test2@example.com',
        phone: '123456789',
        height: 175,
        weight: 70,
        status: 1,
        interactionType: 1,
        createdAt: '2023-01-01T00:00:00.000Z',
        updatedAt: '2023-01-01T00:00:00.000Z',
      );

      // Use a BehaviorSubject to mock the stream
      final stateSubject = BehaviorSubject<UserProfileViewState>.seeded(
          UserProfileLoadSuccess(userProfile));

      when(() => mockBloc.state).thenAnswer((_) => stateSubject.value);
      when(() => mockBloc.stream).thenAnswer((_) => stateSubject.stream);

      // Act
      await tester.pumpWidget(
        BlocProvider<UserProfileViewBloc>(
          create: (context) => mockBloc,
          child: MaterialApp(
              home: ChangeNotifierProvider<LocaleModel>(
                create: (_) => LocaleModel(),
                child: UserProfileViewContentsPage(),
              ),
              localizationsDelegates: [
                AppLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              builder: EasyLoading.init()),
        ),
      );

      // Assert
      expect(find.text('TestUser'), findsOneWidget);
      expect(find.byType(UserProfileSectionPropertyWidget), findsWidgets);

      // Close the BehaviorSubject to avoid memory leaks
      await stateSubject.close();
    });

    testWidgets('should display error message when state is UserLoadFailure',
        (WidgetTester tester) async {
      // when(() => mockBloc.state)
      // .thenReturn(UserLoadFailure('Error loading user'));

      // Arrange
      // Use a BehaviorSubject to mock the stream
      final stateSubject = BehaviorSubject<UserProfileViewState>.seeded(
          UserProfileLoadFailure('Error loading user'));

      when(() => mockBloc.state).thenAnswer((_) => stateSubject.value);
      when(() => mockBloc.stream).thenAnswer((_) => stateSubject.stream);

      // Act
      await tester.pumpWidget(
        BlocProvider<UserProfileViewBloc>(
          create: (context) => mockBloc,
          child: MaterialApp(
              home: ChangeNotifierProvider<LocaleModel>(
                create: (_) => LocaleModel(),
                child: UserProfileViewContentsPage(),
              ),
              localizationsDelegates: [
                AppLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              builder: EasyLoading.init()),
        ),
      );

      // Assert
      expect(find.text('Error loading user'), findsOneWidget);
    });
  });
}
