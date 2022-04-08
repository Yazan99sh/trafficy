import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/module_auth/repository/auth/auth_repository.dart';
@injectable
class AuthManager {
  final AuthRepository _authRepository;
  AuthManager(this._authRepository);
}
