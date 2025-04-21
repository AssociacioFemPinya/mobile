import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fempinya3_flutter_app/core/service_locator.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart' hide sl;


// Mock classes
class MockDio extends Mock implements Dio {}

class MockLogger extends Mock implements Logger {}

void main() {

  Dio? _dio;
  Logger? _logger;

  setUpAll(() {
    setupCommonServiceLocator();
    setupRondesServiceLocator();
    _dio = sl<Dio>();
    _logger = sl<Logger>();
    _dio!.interceptors.clear();
    _dio!.interceptors.add(RondesDioMockInterceptor());
  });

  group('Entities', () {
    test('givenRondaentity_whenCopyWith_thenCopiedRondaHasSameData', () {
      // Arrange
      final rondaEntity = RondaEntity(
        id: 1,
        publicUrl: 'https://example.com',
        ronda: 2,
        name: 'Test Event',
      );

      // Act
      final copiedRondaEntity = rondaEntity.copyWith();

      // Assert
      expect(copiedRondaEntity, isNot(same(rondaEntity)));
      expect(copiedRondaEntity.id, rondaEntity.id);
      expect(copiedRondaEntity.publicUrl, rondaEntity.publicUrl);
      expect(copiedRondaEntity.ronda, rondaEntity.ronda);
      expect(copiedRondaEntity.name, rondaEntity.name);
    });

    test('giverRondaEntity_whenProps_thenSameDataReturned', () {
      // Arrange
      final rondaEntity = RondaEntity(
        id: 1,
        publicUrl: 'https://example.com',
        ronda: 2,
        name: 'Test Event',
      );

      // Act
      final props = rondaEntity.props;

      // Assert
      expect(props, isA<List>());
      expect(props.length, 4);
      expect(props[0], rondaEntity.id);
      expect(props[1], rondaEntity.publicUrl);
      expect(props[2], rondaEntity.ronda);
      expect(props[3], rondaEntity.name);
    });

    test(
        'givenPublicDisplayUrl_whenCopyWith_thenCopiedPublicDisplayUrlHasSameData',
        () {
      // Arrange
      final publicDisplayUrlEntity = PublicDisplayUrlEntity(publicUrl: 'toto');

      // Act
      final copiedPublicDisplayUrl = publicDisplayUrlEntity.copyWith();

      // Assert
      expect(copiedPublicDisplayUrl, isNot(same(publicDisplayUrlEntity)));
      expect(
          copiedPublicDisplayUrl.publicUrl, publicDisplayUrlEntity.publicUrl);
    });

    test('givenPublicDisplayUrl_whenProps_thenSameDataReturned', () {
      final publicDisplayUrlEntity = PublicDisplayUrlEntity(publicUrl: 'toto');

      // Act
      final props = publicDisplayUrlEntity.props;

      // Assert
      expect(props, isA<List>());
      expect(props.length, 1);
      expect(props[0], publicDisplayUrlEntity.publicUrl);
    });
  });

  group('Dio', () {
    test('whenGetRondesList_thenGetRondes', () async {
      var result =
          await sl<GetRondesList>().call(params: GetRondesListParams());

      result.fold(
        (l) => fail('Expected a Right, but got a Left'),
        (rondesList) {
          expect(rondesList, isA<List<RondaEntity>>());
          expect(rondesList.length, 4);
          expect(rondesList[0], isA<RondaEntity>());
          expect(rondesList[0].name, "Lorem ipsum dolor");
          expect(rondesList[0].publicUrl,
              "https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==");
          expect(rondesList[1], isA<RondaEntity>());
          expect(rondesList[1].name, "Lorem ipsum dolor");
          expect(rondesList[1].publicUrl,
              "https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==");
          expect(rondesList[2], isA<RondaEntity>());
          expect(rondesList[2].name, "sit amet.");
          expect(rondesList[2].publicUrl, "");
          expect(rondesList[3], isA<RondaEntity>());
          expect(rondesList[3].name, "Sed quisquam");
          expect(rondesList[3].publicUrl, "mail@mail.com");
        },
      );
    });

    test('givenId_whenGetRonda_thenGetRonda', () async {
      GetRondaParams getRondaParams = GetRondaParams(id: 0);
      var result = await sl<GetRonda>().call(params: getRondaParams);

      result.fold(
        (l) => fail('Expected a Right, but got a Left'),
        (rondaEntity) {
          expect(rondaEntity, isA<RondaEntity>());
          expect(rondaEntity.name, "Lorem ipsum dolor");
          expect(rondaEntity.publicUrl,
              "https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==");
          expect(rondaEntity.ronda, 0);
        },
      );
    });

    test('givenWrongAndNullId_whenGetRonda_thenGetErrorMsg', () async {
      GetRondaParams getRondaParams = GetRondaParams(id: 1000);
      var result = await sl<GetRonda>().call(params: getRondaParams);

      result.fold(
        (l) {
          expect(l, isA<String>());
          expect(l, 'Unknown ronda id');
        },
        (r) => fail('Expected a Left, but got a Right'),
      );

      getRondaParams = GetRondaParams(id: null);
      result = await sl<GetRonda>().call(params: getRondaParams);

      result.fold(
        (l) {
          expect(l, isA<String>());
          expect(l, 'Any ronda id provided');
        },
        (r) => fail('Expected a Left, but got a Right'),
      );
    });

    test('whenGetPublicDisplayUrl_thenGetPublicDisplayUrl',
        () async {
      GetPublicDisplayUrlParams getPublicDisplayUrlParams =
          GetPublicDisplayUrlParams();

      var result = await sl<GetPublicDisplayUrl>()
          .call(params: getPublicDisplayUrlParams);

      result.fold(
        (l) => fail('Expected a Right, but got a Left'),
        (publicDisplayUrl) {
          expect(publicDisplayUrl, isA<PublicDisplayUrlEntity>());
          expect(publicDisplayUrl.publicUrl,
              'https://dev.fempinya.cat/public/display/CdLLeida/cTlTOGl2SHd1Y1o0U0s5WFRyYTFQN3JuRjVwaDloS2xXTUFncWhtbzBuSEc4WTVvV2N3djlEOVZyd1Vic0RoNk1yZncycUd3MEF0NFZJa1RBRDZiMlE9PQ==');
        },
      );
    });
  });

  group('Service', () {
    late RondesServiceImpl rondesService;
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

      // Initialize RondesServiceImpl with the mocked dependencies
      rondesService = RondesServiceImpl();
    });

    tearDown(() {
      // Unregister the mock instances after the test
      sl.unregister<Dio>();
      sl.unregister<Logger>();
      // Register real instances to continue the tests
      sl.registerSingleton<Dio>(_dio!);
      sl.registerSingleton<Logger>(_logger!);
      // Reset mocks
      reset(mockDio);
      reset(mockLogger);
    });

    group('getRondesList', () {

      test(
          'givenDio200ResponseWithUnexpectedData_whenGetRondesList_thenReturnsLeftWithUnexpectedResponseFormatMessage',
          () async {
        // Arrange
        final response = Response(
          data: 'Unexpected data',
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );
        when(() => mockDio.get(RondesApiEndpoints.getRondes))
            .thenAnswer((_) async => response);

        // Act
        final result = await rondesService.getRondesList(GetRondesListParams());

        // Assert
        expect(result.isLeft(), isTrue);
        expect(result.fold((l) => l, (r) => ''), 'Unexpected response format');
      });

      test(
          'givenDioException_whenGetRondesList_thenReturnsLeftWithExceptionMessage',
          () async {
        // Arrange
        when(() => mockDio.get(RondesApiEndpoints.getRondes))
            .thenThrow(Exception('Test Exception'));

        // Act
        final result = await rondesService.getRondesList(GetRondesListParams());

        // Assert
        verify(() => mockLogger.e(any(), any(), any())).called(1);
        expect(result.isLeft(), isTrue);
        expect(result.fold((l) => l, (r) => ''), contains('Test Exception'));
      });
    });

    group('getRonda', () {
      final params = GetRondaParams(id: 1);
      test('givenDioGoodResponse_whenGetRonda_thenReturnsRightWithRondaEntity',
          () async {
        // Arrange
        final response = Response(
          data: {'id': 1, 'name': 'Ronda 1'},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );
        when(() => mockDio.get('${RondesApiEndpoints.getRondes}/${params.id}'))
            .thenAnswer((_) async => response);

        // Act
        final result = await rondesService.getRonda(params);

        // Assert
        expect(result.isRight(), isTrue);
        expect(
            result.getOrElse(() => RondaEntity(id: 1, publicUrl: '', ronda: 1)),
            isA<RondaEntity>());
      });

      test('givenDio400response_whenGetRonda_thenReturnsLeftWithErrorMessage',
          () async {
        // Arrange
        final response = Response(
          data: null,
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        );
        when(() => mockDio.get('${RondesApiEndpoints.getRondes}/${params.id}'))
            .thenAnswer((_) async => response);

        // Act
        final result = await rondesService.getRonda(params);

        // Assert
        expect(result.isLeft(), isTrue);
        expect(result.fold((l) => l, (r) => ''), 'Any ronda id provided');
      });

      test(
          'givenDio200ResponseWithUnexpectedData_whenGetRonda_thenReturnsLeftWithUnexpectedResponseFormatMessage',
          () async {
        // Arrange
        final response = Response(
          data: 'Unexpected data',
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );
        when(() => mockDio.get('${RondesApiEndpoints.getRondes}/${params.id}'))
            .thenAnswer((_) async => response);

        // Act
        final result = await rondesService.getRonda(params);

        // Assert
        expect(result.isLeft(), isTrue);
        expect(result.fold((l) => l, (r) => ''), 'Unexpected response format');
      });

      test('givenDioException_whenGetRonda_thenReturnsLeftWithExceptionMessage',
          () async {
        // Arrange
        when(() => mockDio.get('${RondesApiEndpoints.getRondes}/${params.id}'))
            .thenThrow(Exception('Test Exception'));

        // Act
        final result = await rondesService.getRonda(params);

        // Assert
        verify(() => mockLogger.e(any(), any(), any())).called(1);
        expect(result.isLeft(), isTrue);
        expect(result.fold((l) => l, (r) => ''), contains('Test Exception'));
      });
    });

    group('getPublicDisplayUrl', () {
      test(
          'givenDioGoodResponse_whenGetPublicDisplayUrl_thenReturnsRightWithPublicDisplayUrl',
          () async {
        // Arrange
        final response = Response(
          data: {'url': 'http://example.com/display'},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );
        when(() => mockDio.get(RondesApiEndpoints.getPublicDisplayUrl))
            .thenAnswer((_) async => response);

        // Act
        final result = await rondesService
            .getPublicDisplayUrl(GetPublicDisplayUrlParams());

        // Assert
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => PublicDisplayUrlEntity(publicUrl: 'url')),
            isA<PublicDisplayUrlEntity>());
      });

      test(
          'givenDio200ResponseWithUnexpectedData_whenGetPublicDisplayUrl_thenReturnsLeftWithUnexpectedResponseFormatMessage',
          () async {
        // Arrange
        final response = Response(
          data: 'Unexpected data',
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );
        when(() => mockDio.get(RondesApiEndpoints.getPublicDisplayUrl))
            .thenAnswer((_) async => response);

        // Act
        final result = await rondesService
            .getPublicDisplayUrl(GetPublicDisplayUrlParams());

        // Assert
        expect(result.isLeft(), isTrue);
        expect(result.fold((l) => l, (r) => ''), 'Unexpected response format');
      });

      test(
          'givenDioException_whenGetPublicDisplayUrl_thenReturnsLeftWithExceptionMessage',
          () async {
        // Arrange
        when(() => mockDio.get(RondesApiEndpoints.getPublicDisplayUrl))
            .thenThrow(Exception('Test Exception'));

        // Act
        final result = await rondesService
            .getPublicDisplayUrl(GetPublicDisplayUrlParams());

        // Assert
        verify(() => mockLogger.e(any(), any(), any())).called(1);
        expect(result.isLeft(), isTrue);
        expect(result.fold((l) => l, (r) => ''), contains('Test Exception'));
      });
    });
  });
}
