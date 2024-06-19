import 'package:dio/dio.dart';
import 'package:mashgh/core/error_handling/app_exception.dart';
import 'package:mashgh/core/error_handling/check_exceptions.dart';
import 'package:mashgh/core/params/login_otp_params.dart';
import 'package:mashgh/core/params/user_profile_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/features/feature_auth/data/data_source/remote/api_provider_auth.dart';
import 'package:mashgh/features/feature_auth/data/models/auth_model.dart';
import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';
import 'package:mashgh/features/feature_auth/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final ApiProviderAuth _apiProviderAuth;
  UserRepositoryImpl(this._apiProviderAuth);

  @override
  Future<DataState<UserEntity>> callGenerateOtpApi(
      LoginOtpParams loginOtpParams) async {
    try {
      final Response response =
          await _apiProviderAuth.callGenerateOtpApi(loginOtpParams);

      final UserEntity userEntity = AuthModel.fromJson(response.data);

      return DataSuccess(userEntity);
    } on AppException catch (e) {
      return CheckExceptions.getError(e);
    }
  }

  @override
  Future<DataState<UserEntity>> callLoginOtpApi(
      LoginOtpParams loginOtpParams) async {
    try {
      final Response response =
          await _apiProviderAuth.callLoginOtpApi(loginOtpParams);

      final UserEntity userEntity = AuthModel.fromJson(response.data);

      return DataSuccess(userEntity);
    } on AppException catch (e) {
      return CheckExceptions.getError(e);
    }
  }

  @override
  Future<DataState<UserEntity>> callUpdateUserProfileApi(
      UserProfileParams userProfileParams, String token) async {
    try {
      final Response response = await _apiProviderAuth.callUpdateUserProfileApi(
          userProfileParams, token);

      final UserEntity userEntity = AuthModel.fromJson(response.data);

      return DataSuccess(userEntity);
    } on AppException catch (e) {
      return CheckExceptions.getError(e);
    }
  }
}
