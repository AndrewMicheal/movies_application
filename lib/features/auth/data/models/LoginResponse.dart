import 'package:movies/features/auth/domain/entities/login.dart';

/// message : "Success Login"
/// data : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5MTY2NWM3MjM0MDgzYTYwMmNkNTg0ZCIsImVtYWlsIjoiYW5kcmV3MUB0ZXN0LmNvbSIsImlhdCI6MTc2MzA4NDAwMH0.ZXs44FAEekl5kBTka9HsFnItGVji0ubNgvbmee31WHg"

class LoginResponse {
  LoginResponse({
      this.message, 
      this.data,});

  LoginResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'];
  }
  String? message;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['data'] = data;
    return map;
  }

  Login toLogin() {
    return Login(
       message: message ,
      data: data
    );
  }

}