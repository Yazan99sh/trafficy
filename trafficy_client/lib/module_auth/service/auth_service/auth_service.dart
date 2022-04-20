import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_client/app_write_api.dart';
import 'package:trafficy_client/di/di_config.dart';
import 'package:trafficy_client/module_auth/enums/auth_status.dart';
import 'package:trafficy_client/module_auth/exceptions/auth_exception.dart';
import 'package:trafficy_client/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:trafficy_client/module_auth/presistance/auth_prefs_helper.dart';
import 'package:trafficy_client/module_auth/request/register_request/register_request.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_client/module_home/service/home_service.dart';
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
    var account = getIt<AppwriteApi>().getAccount();
    Logger().info('Login ==>', 'Username => $username');
    Logger().info('Login ==>', 'Password => $password');
    // AppwriteException
    try {
      Session result = await account.createSession(
        email: username,
        password: password,
      );
      _prefsHelper.setToken(result.providerAccessToken);
      _prefsHelper.setUsername(username);
      _prefsHelper.setPassword(password);
      await getIt<HomeService>().checkCalibration();
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
    var account = getIt<AppwriteApi>().getAccount();
    account.deleteSessions();
    await _prefsHelper.cleanAll();
  }
}
