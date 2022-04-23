import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/app_write_api.dart';
import 'package:trafficy_admin/di/di_config.dart';
import 'package:trafficy_admin/module_auth/enums/auth_status.dart';
import 'package:trafficy_admin/module_auth/exceptions/auth_exception.dart';
import 'package:trafficy_admin/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:trafficy_admin/module_auth/presistance/auth_prefs_helper.dart';
import 'package:trafficy_admin/module_auth/request/register_request/register_request.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_admin/utils/helpers/date_converter.dart';
import 'package:trafficy_admin/utils/helpers/status_code_helper.dart';
import 'package:trafficy_admin/utils/logger/logger.dart';

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
    var account = getIt<AppwriteApi>().getAccount();
    Logger().info('Login ==>', 'Username => $username');
    Logger().info('Login ==>', 'Password => $password');
    // AppwriteException
    try {
      Session result = await account.createSession(
        email: username,
        password: password,
      );

      _prefsHelper.setUsername(username);
      _prefsHelper.setPassword(password);
      _prefsHelper.setSession(result.$id);
      _authSubject.add(AuthStatus.AUTHORIZED);
    } catch (e) {
      if (e is AppwriteException) {
        Logger().info('Login Response => ', e.response.toString());
        Logger().info('Login Code => ', e.code.toString());
        Logger().info('Login Message => ', e.message.toString());
        String error =
            StatusCodeHelper.getStatusCodeMessages(e.code.toString());
        _authSubject.addError(error);
        throw AuthorizationException(error);
      } else {
        _authSubject.addError(e.toString());
        throw AuthorizationException(e.toString());
      }
    }
  }

  Future<void> registerApi(RegisterRequest request) async {}

  Future<String?> refreshToken() async {
    try {
      var account = await getIt<AppwriteApi>().getAccount();
      var session =
          await account.getSession(sessionId: _prefsHelper.getSession() ?? '');
      if (DateTime.now().isAfter(DateHelper.convert(session.expire))) {
        throw const AuthorizationException('Session Ended');
      }
      if (DateTime.now()
          .isAfter(DateHelper.convert(session.providerAccessTokenExpiry))) {
        throw const TokenExpiredException('Token Ended');
      }
      return session.providerAccessToken;
    } on AuthorizationException {
      await _prefsHelper.cleanAll();
      return null;
    } on TokenExpiredException {
      await refreshSession();
      return null;
    } catch (e) {
      await _prefsHelper.cleanAll();
      return null;
    }
  }

  /// refresh API token, this is done using Firebase Token Refresh
  Future<void> refreshSession() async {
    String? username = _prefsHelper.getUsername();
    String? password = _prefsHelper.getPassword();
    if (username == null || password == null) {
      throw const AuthorizationException('error getting token');
    }
    await loginApi(username, password);
    return;
  }

  Future<void> logout() async {
    var account = getIt<AppwriteApi>().getAccount();
    account.deleteSessions();
    await _prefsHelper.cleanAll();
  }
}
