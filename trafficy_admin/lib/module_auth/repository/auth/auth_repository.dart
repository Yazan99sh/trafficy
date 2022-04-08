import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/module_network/http_client/http_client.dart';
import 'package:trafficy_admin/utils/logger/logger.dart';

@injectable
class AuthRepository {
  final ApiClient _apiClient;
  final Logger _logger;
  AuthRepository(this._apiClient, this._logger);
}
