import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/module_auth/exceptions/auth_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AuthPrefsHelper {
  var box = Hive.box('Authorization');

  void setUsername(String username) {
    box.put('username', username);
  }

  String? getUsername() {
    return box.get('username');
  }

  void setPassword(String password) {
    box.put('password', password);
  }

  String? getPassword() {
    return box.get('password');
  }

  void setUserCreated(bool created) {
    box.put('created', created);
  }

  void setCalibrated(String id) {
    box.put('calibration', id);
  }

  bool isCalibrated() {
    return box.get('calibration') != null ? true : false;
  }

  String? getCalibrationDocument() {
    return box.get('calibration');
  }

  bool getUserCreated() {
    return box.get('created') ?? false;
  }

  void clearUserCreated() {
    box.delete('created');
  }

  bool isSignedIn() {
    try {
      String? uid = getToken();
      return uid != null;
    } catch (e) {
      return false;
    }
  }

  /// @Function saves token string
  /// @returns void
  void setToken(String? token) {
    if (token != null) {
      box.put('token', token);
    }
  }

  void setTokenDate(String date) {
    box.put(
      'token_date',
      date,
    );
  }

  void setSession(String id) {
    box.put(
      'sessionId',
      id,
    );
  }

  void deleteToken() {
    box.delete('token');
    box.delete('token_date');
  }

  Future<void> cleanAll() async {
    await box.clear();
  }

  /// @return String Token String
  /// @throw Unauthorized Exception when token is null
  String? getToken() {
    var token = box.get('token');
    if (token == null) {
      throw AuthorizationException('Token not found');
    }
    return token;
  }

  String? getSession() {
    var sessionID = box.get('sessionId');
    return sessionID;
  }

  /// @return DateTime tokenDate
  /// @throw UnauthorizedException when token date not found
  DateTime getTokenDate() {
    var dateStr = box.get('token_date');
    if (dateStr == null) {
      throw AuthorizationException('Token date not found');
    }
    return DateTime.parse(dateStr);
  }
}
