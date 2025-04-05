import 'package:fempinya3_flutter_app/global_endpoints.dart';
import 'package:test/test.dart';

void main() {
  group('buildEndpoint', () {
    test(
        'givenEndpointWithSinglePlaceholder_whenBuildEndpointCall_thenEndpointHasValueReplaced',
        () {
      final endpoint =
          'https://api.example.com/notifications/{notificationId}/read';
      final params = {'notificationId': '12345'};
      final expected = 'https://api.example.com/notifications/12345/read';

      final result = buildEndpoint(endpoint, params);

      expect(result, equals(expected));
    });

    test(
        'givenEndpointWithMultiplePlaceholders_whenBuildEndpointCall_thenEndpointHasReplacedValues',
        () {
      final endpoint = 'https://api.example.com/{resource}/{id}/details';
      final params = {'resource': 'users', 'id': '67890'};
      final expected = 'https://api.example.com/users/67890/details';

      final result = buildEndpoint(endpoint, params);

      expect(result, equals(expected));
    });

    test(
        'givenEndpointWithoutPlaceholder_whenBuildEndpointCall_thenSameEndpointReturned',
        () {
      final endpoint = 'https://api.example.com/static/endpoint';
      final Map<String, String> params = {};
      final expected = 'https://api.example.com/static/endpoint';

      final result = buildEndpoint(endpoint, params);

      expect(result, equals(expected));
    });
  });
}
