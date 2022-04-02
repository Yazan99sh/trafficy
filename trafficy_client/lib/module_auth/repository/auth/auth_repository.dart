import 'package:injectable/injectable.dart';
import 'package:trafficy_client/module_network/http_client/http_client.dart';
import 'package:trafficy_client/utils/logger/logger.dart';

@injectable
class AuthRepository {
  final ApiClient _apiClient;
  final Logger _logger;
  AuthRepository(this._apiClient, this._logger);
}
