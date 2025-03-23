class TokenModel {
  final String access_token;
  final String token_type;

  TokenModel({required this.access_token, required this.token_type});

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': access_token,
      'token_type': token_type,
    };
  }

  // Factory constructor for JSON deserialization
  factory TokenModel.fromJson(Map<String, dynamic> data) {
    return TokenModel(
      access_token: data['access_token'] ?? '',
      token_type: data['token_type'] ?? '',
    );
  }
}
