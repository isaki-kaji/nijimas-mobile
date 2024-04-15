class UserAlreadyExistsException implements Exception {
  final String message = "user already exists";
  final String prefix = "userAlreadyExists";
}
