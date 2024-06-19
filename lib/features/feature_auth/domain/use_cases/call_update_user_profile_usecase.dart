import 'package:mashgh/core/params/user_profile_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';
import 'package:mashgh/features/feature_auth/domain/repository/user_repository.dart';

class CallUpdateUserProfileUseCase
    implements UseCase<DataState<UserEntity>, UserProfileParams> {
  final UserRepository userRepository;

  CallUpdateUserProfileUseCase(this.userRepository);

  @override
  Future<DataState<UserEntity>> call(UserProfileParams userProfileParams,
      [String? token]) {
    return userRepository.callUpdateUserProfileApi(
        userProfileParams, token ?? '');
  }
}
