import 'package:mashgh/core/error_handling/check_exceptions.dart';
import 'package:mashgh/core/params/login_otp_params.dart';
import 'package:mashgh/core/params/user_profile_params.dart';
import 'package:mashgh/core/utils/constants.dart';
import 'package:dio/dio.dart';

class ApiProviderAuth {
  final Dio _dio = Dio();

  Future<Response> callGenerateOtpApi(LoginOtpParams loginOtpParams) async {
    try {
      final fromData = FormData.fromMap({
        'phone_number': loginOtpParams.mobile,
      });
      final response = await _dio.post(
        '${Constants.baseUrl}/otp/generate',
        data: fromData,
      );

      return response;
    } on DioException catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  Future<Response> callLoginOtpApi(LoginOtpParams loginOtpParams) async {
    try {
      final fromData = FormData.fromMap({
        'phone_number': loginOtpParams.mobile,
        'otp': loginOtpParams.otp,
        'tracking_code': loginOtpParams.trackingCode,
      });
      final response = await _dio.post(
        '${Constants.baseUrl}/otp/login-otp',
        data: fromData,
      );

      return response;
    } on DioException catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  Future<Response> callUpdateUserProfileApi(
      UserProfileParams userProfileParams, String token) async {
    try {
      final fromData = FormData.fromMap({
        'name': userProfileParams.name,
        'family': userProfileParams.family,
        'age': userProfileParams.age,
        'user_name': userProfileParams.userName,
        'role': userProfileParams.role,
      });

      final response = await _dio.put(
        '${Constants.baseUrl}/specification/store-in/${userProfileParams.mobile}',
        data: fromData,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        }),
      );

      print(response.data);
      print(response.statusCode);

      return response;
    } on DioException catch (e) {
      print(e.response!);
      return CheckExceptions.response(e.response!);
    }
  }
}
