import 'dart:async';
import 'dart:io';
import 'failure.dart';
import 'package:dio/dio.dart';

Failure handleError(Object error, [StackTrace? st]) {
  if (error is DioException) {
    final status = error.response?.statusCode;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure('The request timed out');
      case DioExceptionType.connectionError:
        print(error.message);
        return Failure('Please check your internet connection 1');
      case DioExceptionType.badResponse:
        if (status == 401 || status == 403) {
          return Failure('Authentication required', statusCode: status);
        }
        if (status == 404) {
          return Failure('Not found', statusCode: status);
        }
        if (status != null && status >= 500) {
          return Failure('Server error', statusCode: status);
        }
        return Failure('Invalid server response', statusCode: status);
      case DioExceptionType.cancel:
        return Failure('Request was cancelled');
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return Failure('Please check your internet connection 2');
        }
        return Failure('Unexpected error occurred 123');
      case DioExceptionType.badCertificate:
        return Failure('Bad SSL certificate');
    }
  }

  if (error is TimeoutException) return Failure('The request timed out');
  if (error is SocketException) {
    return Failure('Please check your internet connection');
  }
  if (error is FormatException) return Failure('Data formatting error');
  if (error is FileSystemException) return Failure('Local storage error');

  return Failure('An unexpected error occurred444', details: error.toString());
}
