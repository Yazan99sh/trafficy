import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';
import 'package:trafficy_client/abstracts/states/loading_state.dart';
import 'package:trafficy_client/abstracts/states/state.dart';
import 'package:trafficy_client/di/di_config.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_auth/presistance/auth_prefs_helper.dart';
import 'package:trafficy_client/module_home/home_routes.dart';
import 'package:trafficy_client/module_home/request/create_location_request/create_location_request.dart';
import 'package:trafficy_client/module_home/service/home_service.dart';
import 'package:trafficy_client/module_home/ui/screen/calibration_screen.dart';
import 'package:trafficy_client/module_home/ui/states/calibration_init_state.dart';
import 'package:trafficy_client/utils/helpers/custom_flushbar.dart';

@injectable
class CalibrationStateManager {
  final HomeService _homeService;

  final _subjectState = PublishSubject<States>();
  Stream<States> get state => _subjectState.stream;
  CalibrationStateManager(this._homeService);

  void createLocation(
    CalibrationScreenState screenState,
    CreateLocationRequest request,
  ) {
    _subjectState.add(LoadingState(screenState));
    // check for document
    if (getIt<AuthPrefsHelper>().getCalibrationDocument() != null) {
      _homeService.updateCalibration(request).then((value) {
        if (value.hasError) {
          _subjectState.add(CalibrationInitState(screenState));
          CustomFlushBarHelper.createError(
                  title: S.current.warnning,
                  message: value.error ?? S.current.errorHappened)
              .show(screenState.context);
        } else {
          Navigator.of(screenState.context).pushNamedAndRemoveUntil(
              HomeRoutes.HOME_SCREEN, (route) => false);
          CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning, message: S.current.saveSuccess)
              .show(screenState.context);
        }
      });
    } else {
      // check if there is a document online
      _homeService.checkCalibration().then((value) {
        if (value.hasError) {
          _subjectState.add(CalibrationInitState(screenState));
          CustomFlushBarHelper.createError(
                  title: S.current.warnning,
                  message: value.error ?? S.current.errorHappened)
              .show(screenState.context);
        } else {
          // update
          if (getIt<AuthPrefsHelper>().getCalibrationDocument() != null) {
            createLocation(screenState, request);
          } else {
            // create new Location
            _homeService.createLocation(request).then((value) {
              if (value.hasError) {
                _subjectState.add(CalibrationInitState(screenState));
                CustomFlushBarHelper.createError(
                        title: S.current.warnning,
                        message: value.error ?? S.current.errorHappened)
                    .show(screenState.context);
              } else {
                Navigator.of(screenState.context).pushNamedAndRemoveUntil(
                    HomeRoutes.HOME_SCREEN, (route) => false);
                CustomFlushBarHelper.createSuccess(
                        title: S.current.warnning,
                        message: S.current.saveSuccess)
                    .show(screenState.context);
              }
            });
          }
        }
      });
    }
  }
}
