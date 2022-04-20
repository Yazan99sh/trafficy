import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_admin/module_network/http_client/http_client.dart';

@injectable
class HomeRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  HomeRepository(this._apiClient, this._authService);

}
