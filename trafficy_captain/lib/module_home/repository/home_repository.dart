import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_captain/app_write_api.dart';
import 'package:trafficy_captain/di/di_config.dart';
import 'package:trafficy_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_captain/module_home/hive/home_hive_helper.dart';
import 'package:trafficy_captain/module_home/request/create_location_request/create_location_request.dart';
import 'package:trafficy_captain/module_network/http_client/http_client.dart';
import 'package:trafficy_captain/utils/logger/logger.dart';

@injectable
class HomeRepository {
  final ApiClient _apiClient;
  final Logger _logger;
  final AuthService _authService;
  final AppwriteApi _appwriteApi;
  HomeRepository(
      this._apiClient, this._appwriteApi, this._logger, this._authService);

  Future<AsyncSnapshot> checkLocation() async {
    var database = await _appwriteApi.getDataBase();
    try {
      DocumentList result = await database.listDocuments(
        collectionId: '61d1b52b7af6c',
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
        collectionId: '61d1b52b7af6c',
        data: request.toJson(),
      );
      _logger.info('Request for create Location',
          request.toJson().toString());
      _logger.info('create Document for collection ${result.$collection}',
          result.data.toString());
      getIt<HomeHiveHelper>().setDocumentID(result.$id);
      return AsyncSnapshot.withData(ConnectionState.done, result.data);
    } catch (e) {
      e as AppwriteException;
      _logger.error(
          e.response.toString(), e.message.toString(), StackTrace.current);
      return AsyncSnapshot.withError(ConnectionState.done, e);
    }
  }

  Future<AsyncSnapshot> updateLocation(CreateLocationRequest request) async {
    var document = getIt<HomeHiveHelper>().getDocumentID();
    var database = await _appwriteApi.getDataBase();
    try {
      Document result = await database.updateDocument(
        documentId: document ?? '-1',
        collectionId: '61d1b52b7af6c',
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
}
