import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_captain/abstracts/data_model/data_model.dart';
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
          StatusCodeHelper.getStatusCodeMessages(exception));
    } else {
      return DataModel.empty();
    }
  }
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
    Future<DataModel> updateLocation(CreateLocationRequest request) async {
    AsyncSnapshot snapshot = await _homeRepository.updateLocation(request);
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception));
    } else {
      return DataModel.empty();
    }
  }
}
