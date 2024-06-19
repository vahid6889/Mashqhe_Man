import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';

class AuthModel extends UserEntity {
  const AuthModel({
    super.success,
    super.errorCode,
    super.message,
    super.data,
    super.phoneNumber,
  });

  factory AuthModel.fromJson(dynamic json) {
    Data? data;
    dynamic errorCode;
    if (json['error_code'] != []) {
      errorCode = json['error_code'];
    } else {
      errorCode = [];
    }
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

    return AuthModel(
      success: json['success'],
      errorCode: errorCode,
      message: json['message'],
      data: data,
      phoneNumber: json['phone_number'],
    );
  }
}

class Data {
  Data({
    User? user,
    String? token,
    OtpModel? otp,
  }) {
    _user = user;
    _token = token;
    _otp = otp;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
    _otp = json['OTP'] != null ? OtpModel.fromJson(json['OTP']) : null;
  }
  User? _user;
  String? _token;
  OtpModel? _otp;

  User? get user => _user;
  String? get token => _token;
  OtpModel? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_otp != null) {
      map['OTP'] = _otp?.toJson();
    }
    map['token'] = _token;
    return map;
  }
}

class User {
  User({
    String? userName,
    String? email,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) {
    _userName = userName;
    _email = email;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  User.fromJson(dynamic json) {
    _userName = json['user_name'];
    _email = json['email'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _userName;
  String? _email;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get userName => _userName;
  String? get email => _email;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['email'] = _email;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}

class OtpModel {
  OtpModel({
    String? trackingCode,
    int? waitingTime,
    int? expireAt,
  }) {
    _trackingCode = trackingCode;
    _waitingTime = waitingTime;
    _expireAt = expireAt;
  }

  OtpModel.fromJson(dynamic json) {
    _trackingCode = json['tracking_code'];
    _waitingTime = json['waiting_time'];
    _expireAt = json['expire_at'];
  }
  String? _trackingCode;
  int? _waitingTime;
  int? _expireAt;

  String? get trackingCode => _trackingCode;
  int? get waitingTime => _waitingTime;
  int? get expireAt => _expireAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tracking_code'] = _trackingCode;
    map['waiting_time'] = _waitingTime;
    map['expire_at'] = _expireAt;
    return map;
  }
}
