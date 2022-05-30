import 'package:appwrite/appwrite.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as dartAppwrite;
import 'package:dart_appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/app_write_api.dart';
import 'package:trafficy_admin/app_write_dart_api.dart';
import 'package:trafficy_admin/hive/arguments/ids_hive_helper.dart';
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
  final AppwriteDartApi _appwriteDartApi;
  final Logger _logger;

  CaptainsRepository(this._apiClient, this._authService, this._appwriteApi,
      this._logger, this._appwriteDartApi);
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

  Future<AsyncSnapshot> getProfile() async {
    try {
      User captain =
          await _appwriteDartApi.getUserById(IdsHiveHelper().getCaptainId());
      var result = captain;
      _logger.info('get profile', result.toMap().toString());
      return AsyncSnapshot.withData(ConnectionState.done, result);
    } catch (e) {
      e as AppwriteException;
      _logger.error(
          e.response.toString(), e.message.toString(), StackTrace.current);
      return AsyncSnapshot.withError(ConnectionState.done, e);
    }
  }

  Future<AsyncSnapshot> updatePasswordProfile(String password) async {
    try {
      dartAppwrite.Users users = _appwriteDartApi.getUsers();
      User result = await users.updatePassword(
          userId: IdsHiveHelper().getCaptainId(), password: password);
      _logger.info('updated password Users', result.toMap().toString());
      return AsyncSnapshot.withData(ConnectionState.done, result);
    } catch (e) {
      if (e is AppwriteException) {
        _logger.error(
            e.response.toString(), e.message.toString(), StackTrace.current);
        return AsyncSnapshot.withError(ConnectionState.done, e);
      }
      return AsyncSnapshot.withError(ConnectionState.done, AppwriteException(e.toString()));
    }
  }
}
