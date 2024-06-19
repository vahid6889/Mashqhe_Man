class LoginOtpParams {
  String mobile;
  int? otp;
  String? trackingCode;

  LoginOtpParams({
    required this.mobile,
    this.otp,
    this.trackingCode,
  });
}
