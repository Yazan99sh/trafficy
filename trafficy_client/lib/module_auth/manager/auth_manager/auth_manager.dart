import 'package:injectable/injectable.dart';
import 'package:trafficy_client/module_auth/repository/auth/auth_repository.dart';
import 'package:trafficy_client/module_auth/request/login_request/login_request.dart';
import 'package:trafficy_client/module_auth/request/register_request/register_request.dart';
import 'package:trafficy_client/module_auth/response/login_response/login_response.dart';
import 'package:trafficy_client/module_auth/response/regester_response/regester_response.dart';

@injectable
class AuthManager {
  final AuthRepository _authRepository;
  AuthManager(this._authRepository);

  Future<RegisterResponse?> register(RegisterRequest registerRequest) =>
      _authRepository.createUser(registerRequest);

  Future<LoginResponse?> login(LoginRequest loginRequest) =>
      _authRepository.getToken(loginRequest);
  Future<RegisterResponse?> userTypeCheck(String role, String token) =>
      _authRepository.checkUserType(role, token);
}
