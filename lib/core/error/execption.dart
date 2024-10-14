class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}
