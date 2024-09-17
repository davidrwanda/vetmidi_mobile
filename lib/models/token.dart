class Token {
  final String tokenType;
  final int expiresIn;
  final String accessToken;
  final String refreshToken;

  Token({
    required this.tokenType,
    required this.expiresIn,
    required this.accessToken,
    required this.refreshToken,
  });

  factory Token.fromJSON(Map<String, dynamic> json) {
    return Token(
      tokenType: json["token_type"],
      expiresIn: json["expires_in"],
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token_type': tokenType,
      'expires_in': expiresIn,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  @override
  String toString() {
    return '''{
      tokenType: $tokenType,
      expiresIn: $expiresIn,
      accessToken: $accessToken,
      refreshToken: $refreshToken,
    }''';
  }
}
