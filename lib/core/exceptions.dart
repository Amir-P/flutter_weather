class ServerException implements Exception {
  final int? statusCode;
  final String? message;

  ServerException({required this.statusCode, this.message});
}

class RequestCancelledException implements Exception {
  const RequestCancelledException();
}

class RequestTimedOutException implements Exception {
  const RequestTimedOutException();
}

class BadResponse implements Exception {}
