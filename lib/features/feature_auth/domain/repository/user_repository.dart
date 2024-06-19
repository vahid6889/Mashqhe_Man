import 'package:mashgh/core/params/login_otp_params.dart';
import 'package:mashgh/core/params/user_profile_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<DataState<UserEntity>> callGenerateOtpApi(
      LoginOtpParams loginOtpParams);
  Future<DataState<UserEntity>> callLoginOtpApi(LoginOtpParams loginOtpParams);
  Future<DataState<UserEntity>> callUpdateUserProfileApi(
      UserProfileParams userProfileParams, String token);
}
