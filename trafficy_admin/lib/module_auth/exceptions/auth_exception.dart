import 'dart:core';

class TokenExpiredException implements Exception {
  final String msg;

  const TokenExpiredException(this.msg);

  @override
  String toString() => 'TokenExpiredException ${msg}';
}

class AuthorizationException implements Exception {
  final String msg;

  const AuthorizationException(this.msg);

  @override
  String toString() => msg;
}
