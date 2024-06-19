import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mashgh/core/params/user_profile_params.dart';
import 'package:mashgh/features/feature_auth/domain/use_cases/call_generate_otp_usecase.dart';
import 'package:mashgh/features/feature_auth/domain/use_cases/call_login_otp_usecase.dart';
import 'package:mashgh/features/feature_auth/domain/use_cases/call_update_user_profile_usecase.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/generate_otp_status.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/update_user_profile_status.dart';
import 'package:meta/meta.dart';
import 'package:mashgh/core/params/login_otp_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/login_otp_status.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CallGenerateOtpUseCase _callGenerateOtpUseCase;
  final CallLoginOtpUseCase _callLoginOtpUseCase;
  final CallUpdateUserProfileUseCase _callUpdateUserProfileUseCase;
  AuthBloc(
    this._callGenerateOtpUseCase,
    this._callLoginOtpUseCase,
    this._callUpdateUserProfileUseCase,
  ) : super(
          AuthState(
            loginOtpStatus: LoginOtpInitial(),
            generateOtpStatus: GenerateOtpInitial(),
            updateUserProfileStatus: UpdateUserProfileInitial(),
          ),
        ) {
    on<GenerateOtpEvent>(
      (event, emit) async {
        emit(state.copyWith(newGenerateOtpStatus: GenerateOtpLoading()));

        final DataState<UserEntity> dataState =
            await _callGenerateOtpUseCase(event.loginOtpParams);

        if (dataState is DataSuccess) {
          emit(
            state.copyWith(
              newGenerateOtpStatus: GenerateOtpCompleted(dataState.data),
            ),
          );
        }

        if (dataState is DataFailed) {
          emit(
            state.copyWith(
              newGenerateOtpStatus: GenerateOtpError(dataState.error!),
            ),
          );
        }
      },
    );

    on<GenerateOtpInitialEvent>(
      (event, emit) {
        emit(state.copyWith(newGenerateOtpStatus: GenerateOtpInitial()));
      },
    );

    on<LoginOtpEvent>(
      (event, emit) async {
        emit(state.copyWith(newLoginOtpStatus: LoginOtpLoading()));

        final DataState<UserEntity> dataState =
            await _callLoginOtpUseCase(event.loginOtpParams);

        if (dataState is DataSuccess) {
          emit(
            state.copyWith(
              newLoginOtpStatus: LoginOtpCompleted(dataState.data),
            ),
          );
        }

        if (dataState is DataFailed) {
          emit(
            state.copyWith(
              newLoginOtpStatus: LoginOtpError(dataState.error!),
            ),
          );
        }
      },
    );

    on<UpdateUserProfileEvent>(
      (event, emit) async {
        emit(state.copyWith(
            newUpdateUserProfileStatus: UpdateUserProfileLoading()));

        final DataState<UserEntity> dataState =
            await _callUpdateUserProfileUseCase(
                event.userProfileParams, event.token);

        if (dataState is DataSuccess) {
          emit(
            state.copyWith(
              newUpdateUserProfileStatus:
                  UpdateUserProfileCompleted(dataState.data),
            ),
          );
        }

        if (dataState is DataFailed) {
          emit(
            state.copyWith(
              newUpdateUserProfileStatus:
                  UpdateUserProfileError(dataState.error!),
            ),
          );
        }
      },
    );
  }
}
