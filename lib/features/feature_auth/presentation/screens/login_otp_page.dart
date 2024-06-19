import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mashgh/core/utils/color_manager.dart';
import 'package:mashgh/core/utils/storage_operator.dart';
import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/generate_otp_status.dart';
import 'package:mashgh/features/feature_auth/presentation/screens/verification_otp_page.dart';
import 'package:mashgh/features/feature_auth/presentation/widgets/login_btn.dart';
import 'package:mashgh/locator.dart';
import 'package:sizer/sizer.dart';

StorageOperator storageOperator = locator();

class LoginOtpPage extends StatelessWidget {
  static const routeName = "/login_otp";

  const LoginOtpPage({super.key});

  List<Positioned> backgroundPositionsShapes({
    int? shapeCount,
    double? leftPosition,
    double? bottomPosition,
  }) {
    List<Positioned> listPositions = [];
    Color colorShape = ColorManager.seeBlue.withOpacity(0.2);

    for (var i = 0; i < shapeCount!; i++) {
      if (i % 2 == 0) {
        leftPosition = leftPosition! / 1.sp;
        colorShape = ColorManager.lightGrey.withOpacity(0.1);
      } else {
        bottomPosition = bottomPosition! * 1.5.sp;
        colorShape = ColorManager.seeBlue.withOpacity(0.2);
      }
      listPositions.add(
        Positioned(
          left: leftPosition,
          bottom: bottomPosition,
          child: _rectangleContainer(
            10.w,
            colorShape,
          ),
        ),
      );
    }

    return listPositions;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController mobileController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
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
        // backgroundColor: ColorManager.white,
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
          ...backgroundPositionsShapes(
            shapeCount: 6,
            leftPosition: 15.sp,
            bottomPosition: 40.sp,
          ),
          Positioned(
            left: 17.sp,
            bottom: 25.sp,
            child: _rectangleContainer(
              8.w,
              ColorManager.lightPurple.withOpacity(0.1),
              borderRadius: 9.sp,
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
          Container(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'نمونه شماره موبایل ( 09123333333 )',
                    style: TextStyle(
                      color: ColorManager.darkGrey.withOpacity(0.8),
                      fontSize: 9.sp,
                    ),
                  ),
                  TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 18.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لطفا شماره موبایل خود را وارد';
                      }
                      return null;
                    },
                  ),
                  const Gap(30),
                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) {
                      if (previous.generateOtpStatus ==
                          current.generateOtpStatus) {
                        return false;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      if (state.generateOtpStatus is GenerateOtpLoading) {
                        return const LinearProgressIndicator();
                      }
                      if (state.generateOtpStatus is GenerateOtpCompleted) {
                        /// cast data
                        final GenerateOtpCompleted generateOtpCompleted =
                            state.generateOtpStatus as GenerateOtpCompleted;
                        final UserEntity? userEntity =
                            generateOtpCompleted.userEntity;

                        if (userEntity!.data!.otp!.waitingTime != null) {
                          storageOperator.push('waiting_time',
                              userEntity.data!.otp!.waitingTime.toString());
                          storageOperator.push('expire_at',
                              userEntity.data!.otp!.expireAt.toString());
                        }

                        WidgetsBinding.instance.addPostFrameCallback(
                          (timeStamp) => Navigator.pushNamed(
                            context,
                            VerificationOtpPage.routeName,
                            arguments: <String, dynamic>{
                              'tracking_code':
                                  userEntity.data!.otp!.trackingCode,
                              'waiting_time': userEntity.data!.otp!.waitingTime,
                              'phone_number': mobileController.text,
                            },
                          ),
                        );

                        LoginBtn(
                          mobileController: mobileController,
                          formKey: formKey,
                          backgroundColor:
                              ColorManager.lightPurple.withOpacity(0.1),
                          labelButton: Text(
                            'ارسال کد',
                            style: TextStyle(
                              color: ColorManager.lightPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }
                      if (state.generateOtpStatus is GenerateOtpError) {
                        final GenerateOtpError generateOtpError =
                            state.generateOtpStatus as GenerateOtpError;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            LoginBtn(
                              mobileController: mobileController,
                              formKey: formKey,
                              labelButton: Text(
                                'ارسال کد',
                                style: TextStyle(
                                  color: ColorManager.lightPurple,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
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
                                  generateOtpError.message,
                                  style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return LoginBtn(
                        mobileController: mobileController,
                        formKey: formKey,
                        borderSideColor: ColorManager.darkBlue.withOpacity(0.6),
                        backgroundColor:
                            ColorManager.lightPurple.withOpacity(0.1),
                        labelButton: Text(
                          'ارسال کد',
                          style: TextStyle(
                            color: ColorManager.darkBlue.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _rectangleContainer(
  double height,
  Color color, {
  Color borderColor = Colors.transparent,
  double borderWidth = 20,
  double? borderRadius,
}) {
  return Container(
    height: height,
    width: height,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: color,
      border: Border.all(color: borderColor, width: borderWidth),
      borderRadius: BorderRadius.circular(borderRadius ?? 15),
    ),
  );
}
