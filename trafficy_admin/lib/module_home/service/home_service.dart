import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/data_model/data_model.dart';
import 'package:trafficy_admin/app_write_api.dart';
import 'package:trafficy_admin/di/di_config.dart';
import 'package:trafficy_admin/module_auth/presistance/auth_prefs_helper.dart';
import 'package:trafficy_admin/module_home/model/captains_model.dart';
import 'package:trafficy_admin/module_home/repository/auth/home_repository.dart';
import 'package:trafficy_admin/module_home/request/create_location_request/create_location_request.dart';
import 'package:trafficy_admin/module_home/response/captains_response.dart';
import 'package:trafficy_admin/utils/helpers/status_code_helper.dart';
import 'package:trafficy_admin/utils/logger/logger.dart';

@injectable
class HomeService {
  final HomeRepository _homeRepository;
  HomeService(
    this._homeRepository,
  );

  Future<DataModel> createLocation(CreateLocationRequest request) async {
    AsyncSnapshot snapshot = await _homeRepository.createLocation(request);
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception));
    } else {
      return DataModel.empty();
    }
  }

  Future<DataModel> getCaptains() async {
    AsyncSnapshot snapshot = await _homeRepository.getCaptainsLocation();
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      Logger().info(
          'Error while fetching captains for this reason code ${exception.code}',
          exception.message.toString());
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception));
    } else if (snapshot.hasData) {
      List<CaptainsResponse> response = [];
      List<Document> documents = snapshot.data;
      for (var element in documents) {
        response.add(CaptainsResponse.fromJson(element.data));
      }
      return CaptainsModel.withData(response);
    } else {
      return DataModel.empty();
    }
  }

  /////////////////////////////////////////////////////////
  // check for calibration values
  Future<DataModel> checkCalibration() async {
    AsyncSnapshot snapshot = await _homeRepository.checkCalibration();
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception));
    } else if (snapshot.hasData) {
      List<Document> documents = snapshot.data;
      for (var element in documents) {
        var data = CreateLocationRequest.fromJson(element.data);
        var user = await getIt<AppwriteApi>().getUser();
        if (user.email == data.uid) {
          getIt<AuthPrefsHelper>().setCalibrated(element.$id);
          break;
        }
      }
      return DataModel.empty();
    } else {
      return DataModel.empty();
    }
  }
 // update calibration
  Future<DataModel> updateCalibration(CreateLocationRequest request) async {
    var user = await getIt<AppwriteApi>().getUser();
    request.uid = user.email;
    AsyncSnapshot snapshot = await _homeRepository.updateCalibration(request);
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception));
    } else {
      return DataModel.empty();
    }
  }
}
