import 'package:equatable/equatable.dart';
import 'package:mashgh/features/feature_auth/data/models/auth_model.dart';

class UserEntity extends Equatable {
  final bool? success;
  final dynamic errorCode;
  final String? message;
  final Data? data;
  final int? phoneNumber;

  const UserEntity({
    this.success,
    this.errorCode,
    this.message,
    this.data,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        success,
        errorCode,
        message,
        data,
        phoneNumber,
      ];
}
