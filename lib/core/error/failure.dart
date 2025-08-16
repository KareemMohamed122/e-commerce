class Failure {
  final String message;
  final int? statusCode;
  final Object? details; 
  const Failure(this.message, {this.statusCode, this.details});
}
