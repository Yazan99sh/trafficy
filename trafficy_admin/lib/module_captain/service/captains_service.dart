import 'package:appwrite/appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/data_model/data_model.dart';
import 'package:trafficy_admin/module_captain/model/captain_model.dart';
import 'package:trafficy_admin/module_captain/repository/captains_repository.dart';
import 'package:trafficy_admin/module_captain/request/create_captain_account.dart';
import 'package:trafficy_admin/utils/helpers/status_code_helper.dart';
import 'package:trafficy_admin/utils/logger/logger.dart';

@injectable
class CaptainsService {
  final CaptainsRepository _captainRepository;
  CaptainsService(
    this._captainRepository,
  );

  Future<DataModel> createCaptainAccount(CreateCaptainAccount request) async {
    AsyncSnapshot snapshot =
        await _captainRepository.createCaptainRequest(request);
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      Logger().info(
          'Error while fetching Users for this reason code ${exception.code}',
          exception.message.toString());
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception.code));
    } else {
      return DataModel.empty();
    }
  }

  Future<DataModel> getProfile() async {
    AsyncSnapshot snapshot = await _captainRepository.getProfile();
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      Logger().info(
          'Error while fetching User profile for this reason code ${exception.code}',
          exception.message.toString());
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception.code));
    } else if (snapshot.hasData) {
      User users = snapshot.data;
      return CaptainModel.withData(users);
    } else {
      return DataModel.empty();
    }
  }

  Future<DataModel> updateCaptainPassword(String password) async {
    AsyncSnapshot snapshot =
        await _captainRepository.updatePasswordProfile(password);
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      Logger().info(
          'Error while updating password ${exception.code}',
          exception.message.toString());
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception.code));
    } else {
      return DataModel.empty();
    }
  }
}
