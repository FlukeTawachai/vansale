class ApiException implements Exception {
  String cause;
  ApiException(this.cause);
}

class ApiResponseException implements Exception {
  String cause;
  ApiResponseException(this.cause);
}