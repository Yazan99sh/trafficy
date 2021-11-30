import 'package:injectable/injectable.dart';
import 'package:trafficy_client/consts/urls.dart';
import 'package:trafficy_client/module_auth/request/login_request/login_request.dart';
import 'package:trafficy_client/module_auth/request/register_request/register_request.dart';
import 'package:trafficy_client/module_auth/response/login_response/login_response.dart';
import 'package:trafficy_client/module_auth/response/regester_response/regester_response.dart';
import 'package:trafficy_client/module_network/http_client/http_client.dart';
import 'package:trafficy_client/utils/logger/logger.dart';

@injectable
class AuthRepository {
  final ApiClient _apiClient;
  final Logger _logger;
  AuthRepository(this._apiClient, this._logger);

  Future<RegisterResponse?> createUser(RegisterRequest request) async {
    dynamic result = await _apiClient.post(
      Urls.SIGN_UP_API,
      request.toJson(),
    );
    if (result == null) return null;
    return RegisterResponse.fromJson(result);
  }

  Future<LoginResponse?> getToken(LoginRequest loginRequest) async {
    var result = await _apiClient.post(
      Urls.CREATE_TOKEN_API,
      loginRequest.toJson(),
    );
    if (result == null) {
      return null;
    }
    return LoginResponse.fromJson(result);
  }

  Future<RegisterResponse?> checkUserType(String role, String token) async {
    dynamic result = await _apiClient.post(Urls.CHECK_USER_ROLE + '/$role', {},
        headers: {'Authorization': 'Bearer $token'});

    if (result == null) return null;

    return RegisterResponse.fromJson(result);
  }
}
