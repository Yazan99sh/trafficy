import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/app_write_api.dart';
import 'package:trafficy_admin/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_admin/module_network/http_client/http_client.dart';
import 'package:trafficy_admin/utils/logger/logger.dart';

@injectable
class StatisticsRepository {
  final ApiClient _apiClient;
  final Logger _logger;
  final AuthService _authService;
  final AppwriteApi _appwriteApi;

  StatisticsRepository(
      this._apiClient, this._appwriteApi, this._logger, this._authService);

  Future<AsyncSnapshot> getCaptainsLocation() async {
    var database = await _appwriteApi.getDataBase();
    try {
      DocumentList result = await database.listDocuments(
          collectionId: '61e1e753eafb8', limit: 100);
      _logger.info('get Document for collection ${result.documents}',
          result.toMap().toString());
      return AsyncSnapshot.withData(ConnectionState.done, result.documents);
    } catch (e) {
      e as AppwriteException;
      _logger.error(
          e.response.toString(), e.message.toString(), StackTrace.current);
      return AsyncSnapshot.withError(ConnectionState.done, e);
    }
  }
   Future<AsyncSnapshot> getClientsLocation() async {
    var database = await _appwriteApi.getDataBase();
    try {
      DocumentList result = await database.listDocuments(
          collectionId: '61c789d87c3d1', limit: 100);
      _logger.info('get Document for collection ${result.documents}',
          result.toMap().toString());
      return AsyncSnapshot.withData(ConnectionState.done, result.documents);
    } catch (e) {
      e as AppwriteException;
      _logger.error(
          e.response.toString(), e.message.toString(), StackTrace.current);
      return AsyncSnapshot.withError(ConnectionState.done, e);
    }
  }
}
