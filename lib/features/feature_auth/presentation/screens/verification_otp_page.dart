// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_field, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mashgh/core/params/login_otp_params.dart';
import 'package:mashgh/core/presentation/ui/main_wrapper.dart';
import 'package:mashgh/core/presentation/widgets/toastification_mood.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/core/utils/color_manager.dart';
import 'package:mashgh/core/utils/storage_operator.dart';
import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/login_otp_status.dart';
import 'package:mashgh/features/feature_auth/presentation/cubits/count_down_time_otp_cubit.dart';
import 'package:mashgh/features/feature_auth/presentation/screens/identity_form_page.dart';
import 'package:mashgh/features/feature_auth/presentation/screens/login_otp_page.dart';
import 'package:mashgh/locator.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

StorageOperator storageOperator = locator();

class VerificationOtpPage extends StatefulWidget {
  static const routeName = "/verification_otp";

  const VerificationOtpPage({super.key});

  @override
  State<VerificationOtpPage> createState() => _VerificationOtpPageState();
}

class _VerificationOtpPageState extends State<VerificationOtpPage> {
  final TextEditingController otpController = TextEditingController();
  late ResendTimeOtpCubit resendTimeOtpCubit;
  Map<String, dynamic>? _args;
  String? _trackingCode;
  int? _waitingTime;
  String counterStartTime = '120';
  String? _phoneNumber;
  int resentTime = 0;
  late Timer countDownTime;

  @override
  void initState() {
    // startTimer();
    resendTimeOtpCubit =
        BlocProvider.of<ResendTimeOtpCubit>(context, listen: false)
          ..startTimer();
    resendTimeOtpCubit.emit(resentTime);

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    /// get argument from navigator pages
    _args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _trackingCode = _args?['tracking_code'];
    _waitingTime = _args?['waiting_time'];
    _phoneNumber = _args?['phone_number'];
    int remainingSeconds = 0;

    if (_waitingTime == null) {
      DateTime currentTime = DateTime.now();
      final expireAt = await storageOperator.pull('expire_at_otp');
      counterStartTime = await storageOperator.pull('waiting_time_otp');
      int currentOpenedTime = currentTime.millisecondsSinceEpoch;
      remainingSeconds = int.parse(expireAt) - currentOpenedTime ~/ 1000;
    }

    resentTime = _waitingTime ?? remainingSeconds.abs();
    resendTimeOtpCubit.emit(resentTime);
  }

  @override
  void dispose() {
    resendTimeOtpCubit.dispose();
    super.dispose();
  }

  String strFormating(n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorManager.black,
          ),
          onPressed: () {
            NoParams noParams = NoParams();
            BlocProvider.of<AuthBloc>(context)
                .add(GenerateOtpInitialEvent(noParams));
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginOtpPage.routeName,
              ModalRoute.withName(LoginOtpPage.routeName),
            );
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.seeBlue.withOpacity(0.1),
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: ColorManager.darkpurple.withOpacity(0.3),
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarContrastEnforced: true,
          systemStatusBarContrastEnforced: true,
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.3),
                ColorManager.white,
              ],
              stops: const [
                0.0,
                1.0,
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          BlocConsumer<AuthBloc, AuthState>(
            listenWhen: (previous, current) {
              if (previous.loginOtpStatus == current.loginOtpStatus) {
                return false;
              }
              return true;
            },
            buildWhen: (previous, current) {
              if (previous.loginOtpStatus == current.loginOtpStatus) {
                return false;
              }
              return true;
            },
            listener: (context, state) {
              if (state.loginOtpStatus is LoginOtpError) {
                final LoginOtpError loginOtpError =
                    state.loginOtpStatus as LoginOtpError;

                ToastificationMood.showToast(
                  context: context,
                  typeToast: 'error',
                  titleToast: 'خطای ناخواسته !',
                  descriptionToast: loginOtpError.message,
                );
              }
            },
            builder: (context, state) {
              if (state.loginOtpStatus is LoginOtpLoading) {
                return LinearProgressIndicator(
                  backgroundColor: ColorManager.seeBlue.withOpacity(0.1),
                  color: ColorManager.lightPurple.withOpacity(0.1),
                );
              }
              if (state.loginOtpStatus is LoginOtpCompleted) {
                /// cast data
                final LoginOtpCompleted loginOtpCompleted =
                    state.loginOtpStatus as LoginOtpCompleted;
                final UserEntity? userEntity = loginOtpCompleted.userEntity;

                if (userEntity!.success == false) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gap(5.h),
                      Row(
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            userEntity.message!,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  if (userEntity.isCompleteProfile == true) {
                    storageOperator.push('riseUpAuthentication', 'true');
                    storageOperator.push(
                        'riseUpAuthUserToken', userEntity.data!.token!);
                    WidgetsBinding.instance.addPostFrameCallback(
                      (timeStamp) => Navigator.pushNamedAndRemoveUntil(
                        context,
                        MainWrapper.routeName,
                        ModalRoute.withName(MainWrapper.routeName),
                      ),
                    );
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (timeStamp) => Navigator.pushNamedAndRemoveUntil(
                        context,
                        IdentityFormPage.routeName,
                        ModalRoute.withName(IdentityFormPage.routeName),
                        arguments: <String, dynamic>{
                          'phone_number': _phoneNumber,
                          'rise_up_auth_user_token': userEntity.data!.token!,
                        },
                      ),
                    );
                  }
                }
              }

              return Container();
            },
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                    ColorManager.white,
                    Colors.transparent,
                  ],
                  stops: const [
                    0.0,
                    0.0,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(50.sp),
                  Text(
                    'کد تأیید 4 رقمی دریافتی را تایید کنید',
                    style: TextStyle(
                      color: ColorManager.darkGreyTwo,
                      fontSize: 14.sp,
                    ),
                  ),
                  Gap(20.sp),
                  Text(
                    _phoneNumber.toString(),
                    style: TextStyle(
                      color: ColorManager.darkGreyTwo,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.bottomCenter,
                  end: AlignmentDirectional.topCenter,
                  colors: [
                    ColorManager.darkpurple.withOpacity(0.3),
                    Colors.transparent,
                  ],
                  stops: const [
                    0.1,
                    0.9,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50.sp,
            child: Column(
              children: [
                Center(
                  child: Pinput(
                    controller: otpController,
                    listenForMultipleSmsOnAndroid: true,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    length: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لطفا کد تایید خود را وارد کنید';
                      }
                      if (value.length == 4) {
                        LoginOtpParams loginOtpParams = LoginOtpParams(
                          mobile: _phoneNumber!,
                          otp: int.tryParse(value),
                          trackingCode: _trackingCode,
                        );
                        BlocProvider.of<AuthBloc>(context).add(
                          LoginOtpEvent(loginOtpParams),
                        );
                      }
                      return null;
                    },
                    defaultPinTheme: PinTheme(
                      width: 35.sp,
                      height: 35.sp,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorManager.darkBlue,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 40.sp,
                      height: 40.sp,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorManager.darkBlue,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Gap(80.sp),
                Row(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: BlocBuilder<ResendTimeOtpCubit, int>(
                        builder: (context, state) {
                          if (state == 0) {
                            return InkWell(
                              onTap: () {
                                resentTime = int.parse(counterStartTime);

                                final NoParams noParams = NoParams();
                                BlocProvider.of<AuthBloc>(context)
                                    .add(GenerateOtpInitialEvent(noParams));

                                /// create params for api call
                                final LoginOtpParams loginParams =
                                    LoginOtpParams(
                                  mobile: _phoneNumber!,
                                );

                                BlocProvider.of<AuthBloc>(context).add(
                                  GenerateOtpEvent(loginParams),
                                );
                              },
                              child: Text(
                                'ارسال مجدد',
                                style: TextStyle(
                                  color: ColorManager.darkGreyThree,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            return Text(
                              '${strFormating(state)} ثانیه',
                              style: TextStyle(
                                color: ColorManager.darkRed,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Gap(1.w),
                    Text(
                      'هنوز کد تأیید را دریافت نکرده اید ؟',
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
