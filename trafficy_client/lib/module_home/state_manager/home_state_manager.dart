import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:marker_icon/marker_icon.dart';
import 'package:rxdart/subjects.dart';
import 'package:trafficy_client/abstracts/states/state.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_home/model/captains_model.dart';
import 'package:trafficy_client/module_home/service/calibration_service.dart';
import 'package:trafficy_client/module_home/ui/screen/home_screen.dart';
import 'package:trafficy_client/module_home/ui/states/home_state/home_captains_state_loaded.dart';
import 'package:trafficy_client/utils/helpers/custom_flushbar.dart';

@injectable
class HomeStateManager {
  final HomeService _homeService;

  final _subjectState = PublishSubject<States>();
  Stream<States> get stateSubject => _subjectState.stream;

  HomeStateManager(this._homeService);
  void getCaptains(
    HomeScreenState screenState,
  ) {
    _homeService.getCaptains().then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else if (value.isEmpty) {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened,
                background: Theme.of(screenState.context).primaryColor)
            .show(screenState.context);
      } else {
        CaptainsModel captains = value as CaptainsModel;

        _subjectState.add(HomeCaptainsStateLoaded(screenState,
            captains: captains.data, ));
      }
    });
  }
}
