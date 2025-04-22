import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'package:fempinya3_flutter_app/core/service_locator.dart' hide sl;
import 'package:fempinya3_flutter_app/features/login/login.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

// Mock the Dio class
class MockDio extends Mock implements Dio {}

// Mock the Logger class
class MockLogger extends Mock implements Logger {}

class MockInterceptors extends Mock implements Interceptors {}

class MockInterceptor extends Mock implements Interceptor {}

void main() {

  Dio? _dio;
  Logger? _logger;
  late MockDio mockDio;
  late MockLogger mockLogger;

  setUpAll(() {
    setupCommonServiceLocator();
    setupLoginServiceLocator(true);
    _dio = sl<Dio>();
    _logger = sl<Logger>();
    _dio!.interceptors.clear();
    _dio!.interceptors.add(UsersDioMockInterceptor());
    _dio!.interceptors.add(TokensDioMockInterceptor());
    mockDio = MockDio();
    mockLogger = MockLogger();
    // Register a fallback value for Interceptor
    registerFallbackValue(MockInterceptor());
  });

  group('Entities', () {
    test('givenUserEntity_whenCopyWith_thenCopiedUserHasSameData', () {
      // Arrange
      final linkedCasteller = LinkedCastellerEntity(
        idCastellerApiUser: 1,
        apiUserId: 1,
        castellerId: 1,
      );

      final userEntity = UserEntity(
        castellerActiveId: 1,
        castellerActiveAlias: 'toto',
        linkedCastellers: [linkedCasteller],
        boardsEnabled: false,
      );

      // Act
      final copiedUserEntity = userEntity.copyWith();

      // Assert
      expect(copiedUserEntity, isNot(same(userEntity)));
      expect(copiedUserEntity.castellerActiveId, userEntity.castellerActiveId);
      expect(copiedUserEntity.castellerActiveAlias,
          userEntity.castellerActiveAlias);
      expect(copiedUserEntity.linkedCastellers, userEntity.linkedCastellers);
      expect(copiedUserEntity.boardsEnabled, userEntity.boardsEnabled);

      // Check linkedCastellers
      expect(copiedUserEntity.linkedCastellers.length,
          userEntity.linkedCastellers.length);
      for (int i = 0; i < userEntity.linkedCastellers.length; i++) {
        expect(copiedUserEntity.linkedCastellers[i],
            userEntity.linkedCastellers[i]);
      }
    });

    test('givenUserEntity_whenProps_thenSameDataReturned', () {
      // Arrange
      final linkedCasteller = LinkedCastellerEntity(
        idCastellerApiUser: 1,
        apiUserId: 1,
        castellerId: 1,
      );

      final userEntity = UserEntity(
        castellerActiveId: 1,
        castellerActiveAlias: 'toto',
        linkedCastellers: [linkedCasteller],
        boardsEnabled: false,
      );

      // Act
      final props = userEntity.props;

      // Assert
      expect(props, isA<List>());
      expect(props.length, 4);
      expect(props[0], userEntity.castellerActiveId);
      expect(props[1], userEntity.castellerActiveAlias);
      expect(props[2], userEntity.linkedCastellers);
      expect(props[3], userEntity.boardsEnabled);
    });

    test('givenTokenEntity_whenCopyWith_thenCopiedTokenHasSameData', () {
      // Arrange
      final tokenEntity = TokenEntity(
        access_token: 'sample_access_token',
        token_type: 'Bearer',
      );

      // Act
      final copiedTokenEntity = tokenEntity.copyWith();

      // Assert
      expect(copiedTokenEntity, isNot(same(tokenEntity)));
      expect(copiedTokenEntity.access_token, tokenEntity.access_token);
      expect(copiedTokenEntity.token_type, tokenEntity.token_type);
    });

    test('givenTokenEntity_whenProps_thenSameDataReturned', () {
      // Arrange
      final tokenEntity = TokenEntity(
        access_token: 'sample_access_token',
        token_type: 'Bearer',
      );

      // Act
      final props = tokenEntity.props;

      // Assert
      expect(props, isA<List>());
      expect(props.length, 1);
      expect(props[0], tokenEntity.access_token);
    });

    test('givenTokenModel_whenConvertToJSON_thenConvertedCorrectly', () {
      // Arrange
      final tokenModel = TokenModel(
          access_token: 'test_access_token', token_type: 'test_token_type');

      // Act
      final json = tokenModel.toJson();

      // Assert
      expect(json['access_token'], equals('test_access_token'));
      expect(json['token_type'], equals('test_token_type'));
    });
  });

  group('Service', () {
    late UsersServiceImpl usersService;
    late MockDio mockDio;
    late MockLogger mockLogger;

    setUp(() {
      // Unregister the existing Dio instance
      sl.unregister<Dio>();
      // Unregister the existing Logger instance
      sl.unregister<Logger>();

      // Register the mock Dio instance
      mockDio = MockDio();
      sl.registerSingleton<Dio>(mockDio);

      // Register the mock Logger instance
      mockLogger = MockLogger();
      sl.registerSingleton<Logger>(mockLogger);

      // Initialize UsersServiceImpl with the mocked dependencies
      usersService = UsersServiceImpl();
    });

    tearDown(() {
      // Unregister the mock instances after the test
      sl.unregister<Dio>();
      sl.unregister<Logger>();
      // Register real instances to continue the tests
      sl.registerSingleton<Dio>(_dio!);
      sl.registerSingleton<Logger>(_logger!);
    });

    group('getToken', () {
      test(
          'givenSuccessfulResponse_whenGetToken_thenGetTokenReturnsRightWithTokenEntity',
          () async {
        // Arrange
        final response = Response(
          requestOptions: RequestOptions(path: '/api/auth/login'),
          data: {
            'access_token': 'test_token',
            'token_type': 'bearer',
          },
          statusCode: 200,
        );

        when(() => mockDio.post(
              '/api/auth/login',
              queryParameters: any(named: 'queryParameters'),
            )).thenAnswer((_) async => response);

        // Act
        final result = await usersService.getToken(
            GetTokenParams(mail: 'test@example.com', password: 'password'));

        // Assert
        expect(result, isA<Right<String, TokenEntity>>());
        final tokenEntity = result.getOrElse(() => TokenEntity(
              access_token: '',
              token_type: '',
            ));

        expect(tokenEntity.access_token, 'test_token');
        expect(tokenEntity.token_type, 'bearer');
      });

      test(
          'givenUnexpectedResponseFormat_whenGetToken_thenGetTokenReturnsLeftWithErrorMessage',
          () async {
        // Arrange
        final response = Response(
          requestOptions: RequestOptions(path: '/api/auth/login'),
          data: 'Unexpected data',
          statusCode: 200,
        );

        when(() => mockDio.post(
              '/api/auth/login',
              queryParameters: any(named: 'queryParameters'),
            )).thenAnswer((_) async => response);

        // Act
        final result = await usersService.getToken(
            GetTokenParams(mail: 'test@example.com', password: 'password'));

        // Assert
        expect(result, isA<Left<String, TokenEntity>>());
        final errorMessage = result.swap().getOrElse(() => '');
        expect(errorMessage, equals('Unexpected response format'));
      });

      test('givenException_whenGetToken_thenGeTokenReturnsLeftWithErrorMessage',
          () async {
        // Arrange
        when(() => mockDio.post(
                  '/api/auth/login',
                  queryParameters: any(named: 'queryParameters'),
                ))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        // Act
        final result = await usersService.getToken(
            GetTokenParams(mail: 'test@example.com', password: 'password'));

        // Assert
        expect(result, isA<Left<String, TokenEntity>>());
        final errorMessage = result.swap().getOrElse(() => '');
        expect(errorMessage,
            contains('Error when calling get /api/auth/login endpoint'));
      });
    });
    group('getUser', () {
      test(
          'givenSuccessfulResponse_whenGetUser_thenGetUserReturnsRightWithUserEntity',
          () async {
        // Arrange
        final response = Response(
          requestOptions:
              RequestOptions(path: '/api-fempinya/mobile_user_context'),
          data: {
            'castellerActiveId': 1,
            'castellerActiveAlias': 'Josep Maria',
            'boardsEnabled': true,
            'linkedCastellers': [
              {
                'idCastellerApiUser': 1,
                'apiUserId': 1,
                'castellerId': 1,
              }
            ]
          },
          statusCode: 200,
        );

        when(() => mockDio.get('/api-fempinya/mobile_user_context'))
            .thenAnswer((_) async => response);

        // Act
        final result = await usersService.getUser(GetUserParams());

        // Assert
        expect(result, isA<Right<String, UserEntity>>());
        final userEntity = result.getOrElse(() => UserEntity(
              castellerActiveId: 0,
              castellerActiveAlias: '',
              boardsEnabled: false,
              linkedCastellers: [],
            ));
        expect(userEntity, isA<UserEntity>());
        expect(userEntity.castellerActiveId, 1);
        expect(userEntity.castellerActiveAlias, 'Josep Maria');
        expect(userEntity.boardsEnabled, true);

        // Check linkedCastellers
        expect(userEntity.linkedCastellers.length, 1);
        final linkedCasteller = userEntity.linkedCastellers[0];
        expect(linkedCasteller, isA<LinkedCastellerEntity>());
        expect(linkedCasteller.apiUserId, 1);
        expect(linkedCasteller.castellerId, 1);
        expect(linkedCasteller.idCastellerApiUser, 1);
      });

      test(
          'givenUnexpectedResponseFormat_whenGetUser_thenGetUserReturnsLeftWithErrorMessage',
          () async {
        // Arrange
        final response = Response(
          requestOptions:
              RequestOptions(path: '/api-fempinya/mobile_user_context'),
          data:
              'Unexpected data format', // Simulate an unexpected response format
          statusCode: 200,
        );

        when(() => mockDio.get('/api-fempinya/mobile_user_context'))
            .thenAnswer((_) async => response);

        // Act
        final result = await usersService.getUser(GetUserParams());

        // Assert
        expect(result, isA<Left<String, UserEntity>>());
        final errorMessage = result.swap().getOrElse(() => '');
        expect(errorMessage, equals('Unexpected response format'));
      });

      test('givenException_whenGetUser_thenGetUserReturnsLeftWithErrorMessage',
          () async {
        // Arrange
        final exception = DioException(
          requestOptions:
              RequestOptions(path: '/api-fempinya/mobile_user_context'),
          error: 'Simulated error',
        );

        when(() => mockDio.get('/api-fempinya/mobile_user_context'))
            .thenThrow(exception);

        // Act
        final result = await usersService.getUser(GetUserParams());

        // Assert
        expect(result, isA<Left<String, UserEntity>>());
        final errorMessage = result.swap().getOrElse(() => '');
        expect(
            errorMessage,
            contains(
                'Error when calling get /api-fempinya/mobile_user_context endpoint'));

        // Verify logging
        verify(() => mockLogger.e(
              'Error when calling get /api-fempinya/mobile_user_context endpoint',
              exception,
              any(),
            )).called(1);
      });
    });

    group('setupMockInterceptor', () {
      test('adds interceptor when USE_MOCK_API is true', () {
        // Arrange
        const bool useMockApi = true;
        final mockInterceptors = MockInterceptors();

        // Override the interceptors getter to return the mock interceptors
        when(() => mockDio.interceptors).thenReturn(mockInterceptors);

        // Act
        setupMockInterceptor(useMockApi);

        // Assert
        // Capture the added interceptors
        final captured =
            verify(() => mockInterceptors.add(captureAny())).captured;
        expect(captured, hasLength(2),
            reason: 'Expected two interceptors to be captured');

        // Check the types of the added interceptors
        expect(captured, contains(isA<UsersDioMockInterceptor>()));
        expect(captured, contains(isA<TokensDioMockInterceptor>()));
      });

      test('does not add interceptor when USE_MOCK_API is false', () {
        // Arrange
        const bool useMockApi = false;
        final mockInterceptors = MockInterceptors();

        // Override the interceptors getter to return the mock interceptors
        when(() => mockDio.interceptors).thenReturn(mockInterceptors);

        // Act
        setupMockInterceptor(useMockApi);

        // Assert
        verifyNever(() => mockInterceptors.add(any()));
      });
    });
  });

  group('Repository', () {
    late AuthenticationRepository authRepo;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      // Define the return value for setString and remove
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);
      when(() => mockSharedPreferences.remove(any()))
          .thenAnswer((_) async => true); 
      // Inject the mock SharedPreferences into AuthenticationRepository
      authRepo = AuthenticationRepository(mockSharedPreferences);
    });

    tearDown(() {
      authRepo.dispose();
    });

    test(
        'givenSharedPrefsWithGoodToken_whenInit_thenEmitAuthenticatedStatusWithUser',
        () async {
      //Arrange
      when(() => mockSharedPreferences.getString('auth_token')).thenAnswer(
          (_) => '99|rud6x5D51FyoLHJH1hCncsVfplhdYhuMiUEAG5avbeb88326');

      await expectLater(
        authRepo.status.take(1), // Take only the first emission
        emitsInOrder([
          AuthenticationResult(
              status: AuthenticationStatus.authenticated,
              userEntity: UserEntity(
                castellerActiveId: 1,
                castellerActiveAlias: "Josep Maria",
                linkedCastellers: [
                  LinkedCastellerEntity(
                    idCastellerApiUser: 1,
                    apiUserId: 1,
                    castellerId: 1,
                  ),
                ],
                boardsEnabled: true,
              )),
        ]),
      );
    });

    test(
        'givenSharedPrefsWithWrongToken_whenInit_thenEmitUnauthenticatedStatus',
        () async {
      //Arrange
      _dio!.interceptors
          .removeWhere((interceptor) => interceptor is UsersDioMockInterceptor);
      _dio!.interceptors.add(WrongUsersDioMockInterceptor());
      when(() => mockSharedPreferences.getString('auth_token'))
          .thenAnswer((_) => 'wrong-token');

      //Act
      await expectLater(
        authRepo.status.take(1),
        emitsInOrder([
          AuthenticationResult(status: AuthenticationStatus.unauthenticated),
        ]),
      );

      //Arrange
      _dio!.interceptors.removeWhere(
          (interceptor) => interceptor is WrongUsersDioMockInterceptor);
      _dio!.interceptors.add(UsersDioMockInterceptor());
    });

    test('givenSharedPrefsWithoutToken_whenInit_thenEmitUnauthenticatedStatus',
        () async {
      //Act
      await expectLater(
        authRepo.status.take(1),
        emitsInOrder([
          AuthenticationResult(status: AuthenticationStatus.unauthenticated),
        ]),
      );
    });

    test(
        'givenCorrectMail_whenAuthRepoLogin_thenTokenSavedAndEmitAuthenticatedStatusWithUser',
        () async {
      await authRepo.logIn(mail: 'alanbover@gmail.com', password: '');

      verify(() => mockSharedPreferences.setString('auth_token',
              '99|rud6x5D51FyoLHJH1hCncsVfplhdYhuMiUEAG5avbeb88326'))
          .called(1);

      await expectLater(
        authRepo.status.take(2),
        emitsInOrder([
          AuthenticationResult(
              status: AuthenticationStatus.unauthenticated, userEntity: null),
          AuthenticationResult(
              status: AuthenticationStatus.authenticated,
              userEntity: UserEntity(
                castellerActiveId: 1,
                castellerActiveAlias: "Josep Maria",
                linkedCastellers: [
                  LinkedCastellerEntity(
                    idCastellerApiUser: 1,
                    apiUserId: 1,
                    castellerId: 1,
                  ),
                ],
                boardsEnabled: true,
              )),
        ]),
      );
    });

    test(
        'givenIncorrectMail_whenAuthRepoLogin_thenThrowsAuthExceptionAndEmitsUnauthenticatedStatus',
        () async {
      expect(
        () async =>
            await authRepo.logIn(mail: 'fals@exemple.cat', password: ''),
        throwsA(
          predicate<AuthenticationException>(
            (e) =>
                e.toString() ==
                'AuthenticationException: Invalid username or password',
          ),
        ),
      );

      await expectLater(
        authRepo.status.take(2),
        emitsInOrder([
          AuthenticationResult(status: AuthenticationStatus.unauthenticated),
        ]),
      );
    });

    test('whenLogout_thenTokenDeletedAndEmitsUnauthenticatedStatus', () async {
      await authRepo.logOut();

      verify(() => mockSharedPreferences.remove('auth_token')).called(1);

      await expectLater(
        authRepo.status.take(2),
        emitsInOrder([
          AuthenticationResult(status: AuthenticationStatus.unauthenticated),
        ]),
      );
    });
  });
}

class Failure {
  final String message;

  Failure([this.message = 'An unexpected error occurred']);
}
