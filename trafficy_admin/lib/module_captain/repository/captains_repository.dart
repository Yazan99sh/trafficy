import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/app_write_api.dart';
import 'package:trafficy_admin/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_admin/module_captain/request/create_captain_account.dart';
import 'package:trafficy_admin/module_network/http_client/http_client.dart';
import 'package:trafficy_admin/utils/logger/logger.dart';
import 'package:uuid/uuid.dart';

@injectable
class CaptainsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  final AppwriteApi _appwriteApi;
  final Logger _logger;

  CaptainsRepository(
      this._apiClient, this._authService, this._appwriteApi, this._logger);
  Future<AsyncSnapshot> createCaptainRequest(
      CreateCaptainAccount request) async {
    try {
      Account account = _appwriteApi.getAccount();
      var result = await account.create(
          userId: Uuid().v1(),
          email: request.email,
          password: request.password,
          name: request.name);
      _logger.info('Creating new captain user ${result.$id}', result.email);
      return AsyncSnapshot.withData(ConnectionState.done, result.toMap());
    } catch (e) {
      e as AppwriteException;
      _logger.error(
          e.response.toString(), e.message.toString(), StackTrace.current);
      return AsyncSnapshot.withError(ConnectionState.done, e);
    }
  }
}
