import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/app_write_api.dart';
import 'package:trafficy_admin/app_write_dart_api.dart';
import 'package:trafficy_admin/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_admin/module_network/http_client/http_client.dart';
import 'package:trafficy_admin/utils/logger/logger.dart';

@injectable
class HomeRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  final AppwriteApi _appwriteApi;
  final AppwriteDartApi _appwriteDartApi;
  final Logger _logger;

  HomeRepository(this._apiClient, this._authService, this._appwriteApi,
      this._logger, this._appwriteDartApi);
  Future<AsyncSnapshot> getTrafficyUsers() async {
    try {
      Users users = _appwriteDartApi.getUsers();
      var result = await users.list();
      _logger.info('get Users', result.toMap().toString());
      return AsyncSnapshot.withData(ConnectionState.done, result.users);
    } catch (e) {
      e as AppwriteException;
      _logger.error(
          e.response.toString(), e.message.toString(), StackTrace.current);
      return AsyncSnapshot.withError(ConnectionState.done, e);
    }
  }
}
