part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final LoginOtpStatus loginOtpStatus;
  final GenerateOtpStatus generateOtpStatus;
  final UpdateUserProfileStatus updateUserProfileStatus;

  const AuthState({
    required this.loginOtpStatus,
    required this.generateOtpStatus,
    required this.updateUserProfileStatus,
  });

  AuthState copyWith({
    LoginOtpStatus? newLoginOtpStatus,
    GenerateOtpStatus? newGenerateOtpStatus,
    UpdateUserProfileStatus? newUpdateUserProfileStatus,
  }) {
    return AuthState(
      loginOtpStatus: newLoginOtpStatus ?? loginOtpStatus,
      generateOtpStatus: newGenerateOtpStatus ?? generateOtpStatus,
      updateUserProfileStatus:
          newUpdateUserProfileStatus ?? updateUserProfileStatus,
    );
  }

  @override
  List<Object?> get props => [
        loginOtpStatus,
        generateOtpStatus,
        updateUserProfileStatus,
      ];
}
