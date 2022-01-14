import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_client/app_write_api.dart';
import 'package:trafficy_client/di/di_config.dart';
import 'package:trafficy_client/module_auth/presistance/auth_prefs_helper.dart';
import 'package:trafficy_client/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_client/module_home/request/create_location_request/create_location_request.dart';
import 'package:trafficy_client/module_network/http_client/http_client.dart';
import 'package:trafficy_client/utils/logger/logger.dart';

@injectable
class HomeRepository {
  final ApiClient _apiClient;
  final Logger _logger;
  final AuthService _authService;
  final AppwriteApi _appwriteApi;

  HomeRepository(
      this._apiClient, this._appwriteApi, this._logger, this._authService);

  Future<AsyncSnapshot> checkCalibration() async {
    var database = await _appwriteApi.getDataBase();
    try {
      DocumentList result = await database.listDocuments(
        collectionId: '61c789d87c3d1',
      );
      _logger.info('create Document for collection ${result.documents}',
          result.toMap().toString());
      return AsyncSnapshot.withData(ConnectionState.done, result.documents);
    } catch (e) {
      e as AppwriteException;
      _logger.error(
          e.response.toString(), e.message.toString(), StackTrace.current);
      return AsyncSnapshot.withError(ConnectionState.done, e);
    }
  }
  Future<AsyncSnapshot> createLocation(CreateLocationRequest request) async {
    var database = await _appwriteApi.getDataBase();
    try {
      Document result = await database.createDocument(
        collectionId: '61c789d87c3d1',
        data: request.toJson(),
      );
      _logger.info('create Document for collection ${result.$collection}',
          result.data.toString());
      getIt<AuthPrefsHelper>().setCalibrated(result.$id);
      return AsyncSnapshot.withData(ConnectionState.done, result.data);
    } catch (e) {
      e as AppwriteException;
      _logger.error(
          e.response.toString(), e.message.toString(), StackTrace.current);
      return AsyncSnapshot.withError(ConnectionState.done, e);
    }
  }

  Future<AsyncSnapshot> updateCalibration(CreateLocationRequest request) async {
    var database = await _appwriteApi.getDataBase();
    try {
      Document result = await database.updateDocument(
        collectionId: '61c789d87c3d1',
        documentId:getIt<AuthPrefsHelper>().getCalibrationDocument()??'',
        data: request.toJson(),
      );
      _logger.info('create Document for collection ${result.$collection}',
          result.data.toString());
      return AsyncSnapshot.withData(ConnectionState.done, result.data);
    } catch (e) {
      e as AppwriteException;
      _logger.error(
          e.response.toString(), e.message.toString(), StackTrace.current);
      return AsyncSnapshot.withError(ConnectionState.done, e);
    }
  }

  Future<AsyncSnapshot> getCaptainsLocation() async {
    var database = await _appwriteApi.getDataBase();
    try {
      DocumentList result = await database.listDocuments(
          collectionId: '61d1b52b7af6c', limit: 100);
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
