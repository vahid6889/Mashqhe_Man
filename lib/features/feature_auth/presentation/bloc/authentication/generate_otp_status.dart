import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';

@immutable
abstract class GenerateOtpStatus extends Equatable {}

class GenerateOtpInitial extends GenerateOtpStatus {
  @override
  List<Object?> get props => [];
}

class GenerateOtpLoading extends GenerateOtpStatus {
  @override
  List<Object?> get props => [];
}

class GenerateOtpCompleted extends GenerateOtpStatus {
  final UserEntity? userEntity;

  GenerateOtpCompleted(this.userEntity);

  @override
  List<Object?> get props => [userEntity];
}

class GenerateOtpError extends GenerateOtpStatus {
  final String message;

  GenerateOtpError(this.message);

  @override
  List<Object?> get props => [message];
}
