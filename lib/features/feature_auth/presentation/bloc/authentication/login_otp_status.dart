import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';

@immutable
abstract class LoginOtpStatus extends Equatable {}

class LoginOtpInitial extends LoginOtpStatus {
  @override
  List<Object?> get props => [];
}

class LoginOtpLoading extends LoginOtpStatus {
  @override
  List<Object?> get props => [];
}

class LoginOtpCompleted extends LoginOtpStatus {
  final UserEntity? userEntity;

  LoginOtpCompleted(this.userEntity);

  @override
  List<Object?> get props => [userEntity];
}

class LoginOtpError extends LoginOtpStatus {
  final String message;

  LoginOtpError(this.message);

  @override
  List<Object?> get props => [message];
}
