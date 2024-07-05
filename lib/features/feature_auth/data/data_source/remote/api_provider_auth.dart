import 'dart:io';

import 'package:mashgh/core/error_handling/check_exceptions.dart';
import 'package:mashgh/core/params/login_otp_params.dart';
import 'package:mashgh/core/params/user_profile_params.dart';
import 'package:mashgh/core/utils/constants.dart';
import 'package:dio/dio.dart';

class ApiProviderAuth {
  final Dio _dio = Dio();

  Future<Response> callGenerateOtpApi(LoginOtpParams loginOtpParams) async {
    try {
      final formData = FormData.fromMap({
        'phone_number': loginOtpParams.mobile,
      });
      final response = await _dio.post(
        '${Constants.baseUrl}/otp/generate',
        data: formData,
      );

      return response;
    } on DioException catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  Future<Response> callLoginOtpApi(LoginOtpParams loginOtpParams) async {
    try {
      final formData = FormData.fromMap({
        'phone_number': loginOtpParams.mobile,
        'otp': loginOtpParams.otp,
        'tracking_code': loginOtpParams.trackingCode,
      });
      final response = await _dio.post(
        '${Constants.baseUrl}/otp/login-otp',
        data: formData,
      );

      return response;
    } on DioException catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  Future<Response> callUpdateUserProfileApi(
      UserProfileParams userProfileParams, String token) async {
    try {
      final formData = FormData.fromMap({
        'user_name': userProfileParams.userName,
        'name': userProfileParams.name,
        'family': userProfileParams.family,
        'age': userProfileParams.age,
        'role': userProfileParams.role,
        'phone_number': userProfileParams.mobile,
      });

      final response = await _dio.post(
        '${Constants.baseUrl}/specification/write-in',
        data: formData,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Authorization': 'Bearer $token',
        }),
      );

      return response;
    } on DioException catch (e) {
      print(e.response!);
      return CheckExceptions.response(e.response!);
    }
  }
}
