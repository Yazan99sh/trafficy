import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_admin/abstracts/states/empty_state.dart';
import 'package:trafficy_admin/abstracts/states/error_state.dart';
import 'package:trafficy_admin/abstracts/states/loading_state.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_captain/model/captain_model.dart';
import 'package:trafficy_admin/module_captain/sceens/captain_profile_screen.dart';
import 'package:trafficy_admin/module_captain/service/captains_service.dart';
import 'package:trafficy_admin/module_captain/states/captain_profile_loaded_state.dart';
import 'package:trafficy_admin/module_main/service/home_service.dart';
import 'package:trafficy_admin/utils/helpers/custom_flushbar.dart';

@injectable
class CaptainProfileStateManager {
  final HomeService _homeService;
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CaptainProfileStateManager(this._homeService, this._captainsService);

  void getProfile(CaptainProfileScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getProfile().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getProfile(screenState);
        }, title: '', hasAppbar: false, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getProfile(screenState);
        }, title: '', hasAppbar: false, emptyMessage: S.current.homeDataEmpty));
      } else {
        value as CaptainModel;
        _stateSubject.add(CaptainProfileLoadedState(screenState, value.data));
      }
    });
  }

  void updatePassword(CaptainProfileScreenState screenState, String password) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService.updateCaptainPassword(password).then((value) {
      if (value.hasError) {
        getProfile(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        getProfile(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.passwordUpdated)
            .show(screenState.context);
      }
    });
  }
}
