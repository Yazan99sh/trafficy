import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/data_model/data_model.dart';
import 'package:trafficy_admin/module_clients/repository/clients_repository.dart';
import 'package:trafficy_admin/module_clients/request/create_captain_account.dart';
import 'package:trafficy_admin/utils/helpers/status_code_helper.dart';
import 'package:trafficy_admin/utils/logger/logger.dart';

@injectable
class ClientsService {
  final ClientsRepository _captainRepository;
  ClientsService(
    this._captainRepository,
  );

  Future<DataModel> createClientRequest(CreateClientAccount request) async {
    AsyncSnapshot snapshot =
        await _captainRepository.createClientRequest(request);
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
}
