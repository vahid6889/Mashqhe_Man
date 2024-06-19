part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginOtpEvent extends AuthEvent {
  final LoginOtpParams loginOtpParams;

  LoginOtpEvent(this.loginOtpParams);
}

class LoginOtpInitialEvent extends AuthEvent {
  final NoParams noParams;

  LoginOtpInitialEvent(this.noParams);
}

class GenerateOtpEvent extends AuthEvent {
  final LoginOtpParams loginOtpParams;

  GenerateOtpEvent(this.loginOtpParams);
}

class GenerateOtpInitialEvent extends AuthEvent {
  final NoParams noParams;

  GenerateOtpInitialEvent(this.noParams);
}

class UpdateUserProfileEvent extends AuthEvent {
  final UserProfileParams userProfileParams;
  final String token;

  UpdateUserProfileEvent(this.userProfileParams, this.token);
}

class UpdateUserProfileInitialEvent extends AuthEvent {
  final NoParams noParams;

  UpdateUserProfileInitialEvent(this.noParams);
}

// class LoadSignOutEvent extends AuthEvent {
//   final NoParams noParams;

//   LoadSignOutEvent(this.noParams);
// }
