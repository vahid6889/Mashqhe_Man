import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';

@immutable
abstract class UpdateUserProfileStatus extends Equatable {}

class UpdateUserProfileInitial extends UpdateUserProfileStatus {
  @override
  List<Object?> get props => [];
}

class UpdateUserProfileLoading extends UpdateUserProfileStatus {
  @override
  List<Object?> get props => [];
}

class UpdateUserProfileCompleted extends UpdateUserProfileStatus {
  final UserEntity? userEntity;

  UpdateUserProfileCompleted(this.userEntity);

  @override
  List<Object?> get props => [userEntity];
}

class UpdateUserProfileError extends UpdateUserProfileStatus {
  final String message;

  UpdateUserProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
