import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_client/app_write_api.dart';
import 'package:trafficy_client/app_write_api.dart';
import 'package:trafficy_client/consts/urls.dart';
import 'package:trafficy_client/di/di_config.dart';
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
import 'package:trafficy_client/utils/logger/logger.dart';

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
    var account = await getIt<AppwriteApi>().getAccount();
    Logger().info('Login ==>', 'Username => $username');
    Logger().info('Login ==>', 'Password => $password');
    // AppwriteException
    try {
      Session result = await account.createSession(
        email: username,
        password: password,
      );
      _prefsHelper.setToken(result.providerToken);
      _prefsHelper.setUsername(username);
      _prefsHelper.setPassword(password);
      _authSubject.add(AuthStatus.AUTHORIZED);
    } catch (e) {
      e as AppwriteException;
      Logger().info('Login Response => ', e.response.toString());
      String error = StatusCodeHelper.getStatusCodeMessages(e.code.toString());
      _authSubject.addError(error);
      throw AuthorizationException(error);
    }
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
      var tokenDate = _prefsHelper.getTokenDate();
      var diff = DateTime.now().difference(tokenDate).inMinutes;
      if (diff.abs() > 55) {
        throw TokenExpiredException('Token is created $diff minutes ago');
      }
      return _prefsHelper.getToken();
    } on AuthorizationException {
      _prefsHelper.deleteToken();
      return null;
    } on TokenExpiredException {
      await refreshToken();
      return _prefsHelper.getToken();
    } catch (e) {
      await _prefsHelper.cleanAll();
      return null;
    }
  }

  /// refresh API token, this is done using Firebase Token Refresh
  Future<void> refreshToken() async {
    String? username = _prefsHelper.getUsername();
    String? password = _prefsHelper.getPassword();
    if (username == null || password == null) {
      throw const AuthorizationException('error getting token');
    }
    await loginApi(username, password);
    return;
  }

  Future<void> logout() async {
    var account = await getIt<AppwriteApi>().getAccount();
    account.deleteSessions();
    await _prefsHelper.cleanAll();
  }
}
