import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/core/service_locator.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart' hide sl;

import 'package:test/test.dart';

void main() {
  setUpAll(() {
    setupCommonServiceLocator();
    setupRondesServiceLocator();
    final Dio _dio = sl<Dio>();
    _dio.interceptors.clear();
    _dio.interceptors.add(RondesDioMockInterceptor());
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

    test('givenEmail_whenGetPublicDisplayUrl_thenGetPublicDisplayUrl',
        () async {
      GetPublicDisplayUrlParams getPublicDisplayUrlParams =
          GetPublicDisplayUrlParams(email: 'mail@mail.com');

      var result = await sl<GetPublicDisplayUrl>()
          .call(params: getPublicDisplayUrlParams);

      result.fold(
        (l) => fail('Expected a Right, but got a Left'),
        (publicDisplayUrl) {
          expect(publicDisplayUrl, isA<PublicDisplayUrlEntity>());
          expect(publicDisplayUrl.publicUrl,
              'https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==');
        },
      );
    });

    test('givenNullEmail_whenGetPublicDisplayUrl_thenGetErrorMsg', () async {
      GetPublicDisplayUrlParams getPublicDisplayUrlParams =
          GetPublicDisplayUrlParams(email: null);

      var result = await sl<GetPublicDisplayUrl>()
          .call(params: getPublicDisplayUrlParams);

      result.fold(
        (l) {
          expect(l, isA<String>());
          expect(l, 'Any user email provided');
        },
        (r) => fail('Expected a Left, but got a Right'),
      );
    });

    test('givenWrongEmail_whenGetPublicDisplayUrl_thenGetErrorMsg', () async {
      GetPublicDisplayUrlParams getPublicDisplayUrlParams =
          GetPublicDisplayUrlParams(email: "toto@toto.com");

      var result = await sl<GetPublicDisplayUrl>()
          .call(params: getPublicDisplayUrlParams);

      result.fold(
        (l) {
          expect(l, isA<String>());
          expect(l, 'Unknown email');
        },
        (r) => fail('Expected a Left, but got a Right'),
      );
    });

    test(
        'givenEmail_whenGetPublicDisplayUrlWithEmptyUrl_thenGetPublicDisplayUrlWithEmptyUrl',
        () async {
      GetPublicDisplayUrlParams getPublicDisplayUrlParams =
          GetPublicDisplayUrlParams(email: "emptyUrl@mail.com");

      var result = await sl<GetPublicDisplayUrl>()
          .call(params: getPublicDisplayUrlParams);

      result.fold(
        (l) => fail('Expected a Right, but got a Left'),
        (publicDisplayUrl) {
          expect(publicDisplayUrl, isA<PublicDisplayUrlEntity>());
          expect(publicDisplayUrl.publicUrl, '');
        },
      );
    });

  });
}
