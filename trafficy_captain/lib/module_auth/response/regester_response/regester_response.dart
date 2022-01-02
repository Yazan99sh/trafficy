import 'package:trafficy_captain/utils/logger/logger.dart';

class RegisterResponse {
  String? statusCode;
  String? msg;
  dynamic data;

  RegisterResponse({this.statusCode, this.msg, this.data});

  RegisterResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'];
    } catch (e) {
      Logger()
          .error('Auth Register Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }
}
