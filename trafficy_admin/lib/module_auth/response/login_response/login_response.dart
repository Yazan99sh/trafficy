import 'package:trafficy_admin/utils/logger/logger.dart';

class LoginResponse {
  String? token;
  String? statusCode;
  LoginResponse({this.token, this.statusCode});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    try {
      token = json['token'];
      statusCode = json['code'] ?? json['statusCode'] ?? json['status_code'];
    } catch (e) {
      Logger().error('Auth Login Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = this.token;
    return data;
  }
}
