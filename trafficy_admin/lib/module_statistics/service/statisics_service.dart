import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/data_model/data_model.dart';
import 'package:trafficy_admin/module_statistics/model/captains_model.dart';
import 'package:trafficy_admin/module_statistics/model/clients_model.dart';
import 'package:trafficy_admin/module_statistics/repository/statistics_repository.dart';
import 'package:trafficy_admin/module_statistics/response/captains_response.dart';
import 'package:trafficy_admin/module_statistics/response/clients_response.dart';
import 'package:trafficy_admin/utils/helpers/status_code_helper.dart';
import 'package:trafficy_admin/utils/logger/logger.dart';

@injectable
class StatisticsService {
  final StatisticsRepository _statisticsRepository;
  StatisticsService(
    this._statisticsRepository,
  );

  Future<DataModel> getCaptains() async {
    AsyncSnapshot snapshot = await _statisticsRepository.getCaptainsLocation();
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      Logger().info(
          'Error while fetching captains for this reason code ${exception.code}',
          exception.message.toString());
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception.code));
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

  Future<DataModel> getClients() async {
    AsyncSnapshot snapshot = await _statisticsRepository.getClientsLocation();
    if (snapshot.hasError) {
      AppwriteException exception = snapshot.error as AppwriteException;
      Logger().info(
          'Error while fetching clients for this reason code ${exception.code}',
          exception.message.toString());
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(exception.code));
    } else if (snapshot.hasData) {
      List<ClientsResponse> response = [];
      List<Document> documents = snapshot.data;
      for (var element in documents) {
        response.add(ClientsResponse.fromJson(element.data));
      }
      return ClientsModel.withData(response);
    } else {
      return DataModel.empty();
    }
  }
}
