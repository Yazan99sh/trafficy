import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/data_model/data_model.dart';
import 'package:trafficy_admin/module_main/model/users_models.dart';

import 'package:trafficy_admin/module_main/repository/home_repository.dart';
import 'package:trafficy_admin/utils/helpers/status_code_helper.dart';
import 'package:trafficy_admin/utils/logger/logger.dart';

@injectable
class HomeService {
  final HomeRepository _homeRepository;
  HomeService(
    this._homeRepository,
  );

  Future<DataModel> getUsersCount() async {
    AsyncSnapshot snapshot = await _homeRepository.getTrafficyUsers();
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      Logger().info(
          'Error while fetching Users for this reason code ${exception.code}',
          exception.message.toString());
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception.code));
    } else if (snapshot.hasData) {
      List<User> users = snapshot.data;
      return UsersModel.withData(users);
    } else {
      return DataModel.empty();
    }
  }
}
