class GlobalEndpoints {
  static const String apiBaseUrl = 'https://api.dev.fempinya.cat';
}

// Helper method that takes the endpoint and the dynamic parameter,
// and replaces the placeholder with the actual value
String buildEndpoint(String endpoint, Map<String, String> params) {
  String result = endpoint;
  params.forEach((key, value) {
    result = result.replaceAll('{$key}', value);
  });
  return result;
}
