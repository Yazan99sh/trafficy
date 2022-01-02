import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';
import 'package:trafficy_captain/abstracts/states/error_state.dart';
import 'package:trafficy_captain/abstracts/states/loading_state.dart';
import 'package:trafficy_captain/abstracts/states/state.dart';
import 'package:trafficy_captain/di/di_config.dart';
import 'package:trafficy_captain/generated/l10n.dart';
import 'package:trafficy_captain/module_auth/presistance/auth_prefs_helper.dart';
import 'package:trafficy_captain/module_home/home_routes.dart';
import 'package:trafficy_captain/module_home/request/create_location_request/create_location_request.dart';
import 'package:trafficy_captain/module_home/service/calibration_service.dart';
import 'package:trafficy_captain/module_home/ui/screen/calibration_screen.dart';
import 'package:trafficy_captain/module_home/ui/states/calibration_init_state.dart';
import 'package:trafficy_captain/utils/helpers/custom_flushbar.dart';

@injectable
class CalibrationStateManager {
  final HomeService _homeService;

  final _subjectState = PublishSubject<States>();

  CalibrationStateManager(this._homeService);
  void createLocation(
    CalibrationScreenState screenState,
    CreateLocationRequest request,
  ) {
    _subjectState.add(LoadingState(screenState));
    _homeService.createLocation(request).then((value) {
      if (value.hasError) {
        _subjectState.add(CalibrationInitState(screenState));
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        _subjectState.add(CalibrationInitState(screenState));
        getIt<AuthPrefsHelper>().setCalibrated();
        Navigator.of(screenState.context)
            .pushNamedAndRemoveUntil(HomeRoutes.HOME_SCREEN, (route) => false);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.saveSuccess)
            .show(screenState.context);
      }
    });
  }
}
