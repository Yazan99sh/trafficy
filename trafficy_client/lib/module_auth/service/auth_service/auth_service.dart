import 'package:injectable/injectable.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_auth/enums/auth_status.dart';
import 'package:trafficy_client/module_auth/exceptions/auth_exception.dart';
import 'package:trafficy_client/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:trafficy_client/module_auth/presistance/auth_prefs_helper.dart';
import 'package:trafficy_client/module_auth/request/login_request/login_request.dart';
import 'package:trafficy_client/module_auth/request/register_request/register_request.dart';
import 'package:trafficy_client/module_auth/response/login_response/login_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_client/module_auth/response/regester_response/regester_response.dart';
import 'package:trafficy_client/utils/helpers/status_code_helper.dart';

@Injectable()
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final PublishSubject<AuthStatus> _authSubject = PublishSubject<AuthStatus>();

  AuthService(
    this._prefsHelper,
    this._authManager,
  );

  bool get isLoggedIn => _prefsHelper.isSignedIn();

  Stream<AuthStatus> get authListener => _authSubject.stream;
  String get username => _prefsHelper.getUsername() ?? '';

  Future<void> loginApi(String username, String password) async {
    LoginResponse? loginResult = await _authManager.login(LoginRequest(
      username: username,
      password: password,
    ));
    if (loginResult == null) {
      await logout();
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (loginResult.statusCode == '401') {
      await logout();
      _authSubject.addError(S.current.invalidCredentials);
      throw AuthorizationException(S.current.networkError);
    } else if (loginResult.token == null) {
      await logout();
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          loginResult.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          loginResult.statusCode ?? '0'));
    }
    RegisterResponse? response = await _authManager.userTypeCheck(
        'ROLE_CLIENT', loginResult.token ?? '');
    if (response?.statusCode != '201') {
      await logout();
      _authSubject.addError(
          StatusCodeHelper.getStatusCodeMessages(response?.statusCode ?? '0'));
      throw AuthorizationException(
          StatusCodeHelper.getStatusCodeMessages(response?.statusCode ?? '0'));
    }
    _prefsHelper.setUsername(username);
    _prefsHelper.setPassword(password);
    _prefsHelper.setToken(loginResult.token);
    _authSubject.add(AuthStatus.AUTHORIZED);
  }

  Future<void> registerApi(RegisterRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse = await _authManager.register(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '201') {
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    }
    _authSubject.add(AuthStatus.REGISTERED);
    await loginApi(request.userID ?? '', request.password ?? '');
  }

  Future<String?> getToken() async {
    try {
      var tokenDate = this._prefsHelper.getTokenDate();
      var diff = DateTime.now().difference(tokenDate).inMinutes;
      if (diff.abs() > 55) {
        throw TokenExpiredException('Token is created ${diff} minutes ago');
      }
      return await this._prefsHelper.getToken();
    } on AuthorizationException {
      _prefsHelper.deleteToken();
      return null;
    } on TokenExpiredException {
      return await refreshToken();
    } catch (e) {
      await _prefsHelper.cleanAll();
      return null;
    }
  }

  /// refresh API token, this is done using Firebase Token Refresh
  Future<String?> refreshToken() async {
    String? username = await _prefsHelper.getUsername();
    String? password = await _prefsHelper.getPassword();
    LoginResponse? loginResponse = await _authManager.login(LoginRequest(
      username: username,
      password: password,
    ));
    if (loginResponse == null) {
      await _prefsHelper.cleanAll();
      return null;
    }
    _prefsHelper.setToken(loginResponse.token);

    return loginResponse.token;
  }

  Future<void> logout() async {
    await _prefsHelper.cleanAll();
  }
}
