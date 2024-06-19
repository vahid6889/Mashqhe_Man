import 'package:dio/dio.dart';

class AppException implements Exception {
  final String? message;
  Response? response;

  AppException({required this.message, this.response});

  String getMessage() {
    return "$message";
  }

  String getResponse() {
    return "$response";
  }
}

class ServerException extends AppException {
  ServerException({String? message, Response? response})
      : super(message: message ?? "مشکلی پیش آمده لطفا دوباره امتحان کنید");
}

class NotFoundException extends AppException {
  NotFoundException({String? message})
      : super(message: message ?? "صفحه مورد نظر یافت نشد.");
}

class DataParsingException extends AppException {
  DataParsingException({String? message})
      : super(message: message ?? "داده ها خراب شده است");
}

class BadRequestException extends AppException {
  BadRequestException({String? message, super.response})
      : super(message: message ?? "داده ها خراب شده است");
}

class FetchDataException extends AppException {
  FetchDataException({String? message})
      : super(message: message ?? "لطفا اتصال خود را بررسی کنید");
}

class UnauthorisedException extends AppException {
  UnauthorisedException({String? message})
      : super(message: message ?? "توکن منقضی شده است");
}
