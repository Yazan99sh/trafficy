import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_client/app_write_api.dart';
import 'package:trafficy_client/consts/urls.dart';
import 'package:trafficy_client/module_auth/request/login_request/login_request.dart';
import 'package:trafficy_client/module_auth/request/register_request/register_request.dart';
import 'package:trafficy_client/module_auth/response/login_response/login_response.dart';
import 'package:trafficy_client/module_auth/response/regester_response/regester_response.dart';
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
  Future<AsyncSnapshot> createLocation(CreateLocationRequest request) async {
    var database = await _appwriteApi.getDataBase();
    try {
      Document result = await database.createDocument(
        collectionId: '61c789d87c3d1',
        data: request.toJson(),
      );
      _logger.info('create Document for collection ${result.$collection}', result.data.toString());
      return AsyncSnapshot.withData(ConnectionState.done, result.data);
    } catch (e) {
      e as AppwriteException;
      _logger.error(e.response.toString(),e.message.toString(),StackTrace.current);
      return AsyncSnapshot.withError(ConnectionState.done, e);
    }
  }
}
