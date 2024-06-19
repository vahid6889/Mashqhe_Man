import 'package:mashgh/core/params/login_otp_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';
import 'package:mashgh/features/feature_auth/domain/repository/user_repository.dart';

class CallGenerateOtpUseCase
    implements UseCase<DataState<UserEntity>, LoginOtpParams> {
  final UserRepository userRepository;

  CallGenerateOtpUseCase(this.userRepository);

  @override
  Future<DataState<UserEntity>> call(LoginOtpParams loginParams) {
    return userRepository.callGenerateOtpApi(loginParams);
  }
}
