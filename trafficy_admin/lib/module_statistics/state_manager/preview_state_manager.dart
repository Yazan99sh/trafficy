import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';
import 'package:trafficy_admin/abstracts/data_model/data_model.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_deep_links/service/deep_links_service.dart';
import 'package:trafficy_admin/module_statistics/model/captains_model.dart';
import 'package:trafficy_admin/module_statistics/model/clients_model.dart';
import 'package:trafficy_admin/module_statistics/sceens/preview_screen.dart';
import 'package:trafficy_admin/module_statistics/service/statisics_service.dart';
import 'package:trafficy_admin/module_statistics/states/preview_loaded_state.dart';
import 'package:trafficy_admin/utils/helpers/custom_flushbar.dart';

@injectable
class PreviewStateManager {
  final StatisticsService _statisticsService;

  final _subjectState = PublishSubject<States>();
  Stream<States> get stateSubject => _subjectState.stream;

  PreviewStateManager(this._statisticsService);
  void getAllUserLocations(PreviewScreenState screenState) {
    Future.wait(
            [_statisticsService.getClients(), _statisticsService.getCaptains()])
        .then((List<DataModel> value) async {
      var currentLocation = await DeepLinksService.defaultLocation();
      if (value[0].hasError || value[1].hasError) {
        if (value[0].hasError && value[1].hasError) {
          CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value[0].error ?? '')
              .show(screenState.context)
              .whenComplete(() {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning, message: value[1].error ?? '')
                .show(screenState.context);
          });
          _subjectState.add(PreviewLoadedState(screenState,
              captains: [], clients: [], myPos: currentLocation));
        } else {
          if (value[0].hasError) {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning, message: value[0].error ?? '')
                .show(screenState.context);
            var clients = value[1] as ClientsModel;
            _subjectState.add(PreviewLoadedState(screenState,
                captains: [], clients: clients.data, myPos: currentLocation));
          }
          if (value[1].hasError) {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning, message: value[1].error ?? '')
                .show(screenState.context);
            var captains = value[1] as CaptainsModel;
            _subjectState.add(PreviewLoadedState(screenState,
                captains: captains.data, clients: [], myPos: currentLocation));
          }
        }
      } else if (value[0].isEmpty || value[1].isEmpty) {
        if (value[0].isEmpty && value[1].isEmpty) {
          CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.homeDataEmpty,
                  background: Theme.of(screenState.context).colorScheme.primary)
              .show(screenState.context);
        }
        dynamic clients =
            value[0].isEmpty ? <ClientsModel>[] : (value[0] as ClientsModel);
        dynamic captains =
            value[1].isEmpty ? <CaptainsModel>[] : (value[1] as CaptainsModel);
        _subjectState.add(PreviewLoadedState(screenState,
            captains:
                captains is CaptainsModel ? captains.data : <CaptainsModel>[],
            clients: clients is ClientsModel ? clients.data : <ClientsModel>[],
            myPos: currentLocation));
      } else {
        var clients = value[0] as ClientsModel;
        var captains = value[1] as CaptainsModel;
        _subjectState.add(PreviewLoadedState(screenState,
            captains: captains.data,
            clients: clients.data,
            myPos: currentLocation));
      }
    });
  }
}
