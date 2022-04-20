import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_captain/abstracts/data_model/data_model.dart';
import 'package:trafficy_captain/app_write_api.dart';
import 'package:trafficy_captain/di/di_config.dart';
import 'package:trafficy_captain/module_home/hive/home_hive_helper.dart';
import 'package:trafficy_captain/module_home/repository/home_repository.dart';
import 'package:trafficy_captain/module_home/request/create_location_request/create_location_request.dart';
import 'package:trafficy_captain/utils/helpers/status_code_helper.dart';

@injectable
class HomeService {
  final HomeRepository _homeRepository;

  HomeService(
    this._homeRepository,
  );

  Future<DataModel> checkLocation() async {
    AsyncSnapshot snapshot = await _homeRepository.checkLocation();
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception.code));
    } else if (snapshot.hasData) {
      List<Document> documents = snapshot.data;
      for (var element in documents) {
        var data = CreateLocationRequest.fromJson(element.data);
        var user = await getIt<AppwriteApi>().getUser();
        if (user.email == data.uid) {
          getIt<HomeHiveHelper>().setDocumentID(element.$id);
          break;
        }
      }
      return DataModel.empty();
    } else {
      return DataModel.empty();
    }
  }

  Future<DataModel> createLocation(CreateLocationRequest request) async {
    var account = await getIt<AppwriteApi>().getAccount();
    var user = await account.get();
    request.name = user.name;
    AsyncSnapshot snapshot = await _homeRepository.createLocation(request);
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception.code));
    } else {
      return DataModel.empty();
    }
  }

  Future<DataModel> updateLocation(CreateLocationRequest request) async {
    var account = await getIt<AppwriteApi>().getAccount();
    var user = await account.get();
    request.name = user.name;
    AsyncSnapshot snapshot = await _homeRepository
        .updateLocation(request)
        ;
    if (snapshot.hasError) {
      snapshot = await _homeRepository.deleteLocation();
      snapshot = await _homeRepository.createLocation(request);
      if (snapshot.hasError) {
        await getIt<HomeHiveHelper>().clean();
        AppwriteException exception = snapshot.error as AppwriteException;
        return DataModel.withError(
            StatusCodeHelper.getStatusCodeMessages(exception.code));
      }
      return DataModel.empty();
    } else {
      return DataModel.empty();
    }
  }
}
