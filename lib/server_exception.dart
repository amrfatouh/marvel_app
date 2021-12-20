class ServerException implements Exception {
  String message;

  ServerException(this.message);

  @override
  String toString() {
    return 'ServerException(message: $message)';
  }
}
