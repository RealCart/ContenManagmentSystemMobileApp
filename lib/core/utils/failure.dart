import 'package:dio/dio.dart';

abstract class Failure implements Exception {
  Failure({required this.errorMessage, this.errorCode});

  int? errorCode;
  final String errorMessage;
}

class BadResponseFailure extends Failure {
  BadResponseFailure({super.errorCode, required super.errorMessage});
}

class NetworkFailure extends Failure {
  NetworkFailure({super.errorCode, required super.errorMessage});
}

class TimeoutFailure extends Failure {
  TimeoutFailure({super.errorCode, required super.errorMessage});
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure({super.errorCode, required super.errorMessage});
}

Failure dioErrorWrapper(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return TimeoutFailure(
        errorMessage: "Server is not responding. Try again later",
      );
    case DioExceptionType.connectionError:
      return NetworkFailure(errorMessage: "Check your internet connection");
    case DioExceptionType.badResponse:
      final String msg =
          (e.response?.data is Map && e.response!.data["message"] is String)
          ? e.response!.data["message"] as String
          : "Server error!";
      return NetworkFailure(errorMessage: msg);
    default:
      return UnexpectedFailure(errorMessage: e.message ?? "");
  }
}
