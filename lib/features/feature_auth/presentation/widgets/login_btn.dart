import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashgh/core/params/login_otp_params.dart';
import 'package:mashgh/core/utils/color_manager.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/auth_bloc.dart';

class LoginBtn extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? mobileController;
  final GlobalKey<FormState> formKey;
  final Text? labelButton;
  final Color? borderSideColor, backgroundColor;
  const LoginBtn({
    super.key,
    this.emailController,
    this.passwordController,
    this.mobileController,
    required this.formKey,
    this.labelButton,
    this.borderSideColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          /// create params for api call
          final LoginOtpParams loginParams = LoginOtpParams(
            mobile: mobileController!.text,
          );

          BlocProvider.of<AuthBloc>(context).add(
            GenerateOtpEvent(loginParams),
          );
        }
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(
          width: 2,
          color: borderSideColor ?? ColorManager.black.withOpacity(0.7),
        ),
      ),
      child: labelButton ?? const Text('Login'),
    );
  }
}
