import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_admin/abstracts/states/empty_state.dart';
import 'package:trafficy_admin/abstracts/states/error_state.dart';
import 'package:trafficy_admin/abstracts/states/loading_state.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_main/model/users_models.dart';
import 'package:trafficy_admin/module_main/sceen/home_screen.dart';
import 'package:trafficy_admin/module_main/sceen/home_state/home_state_loaded.dart';
import 'package:trafficy_admin/module_main/service/home_service.dart';

@injectable
class HomeStateManager {
  final HomeService _homeService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  HomeStateManager(this._homeService);

  void getUsers(HomeScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _homeService.getUsersCount().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getUsers(screenState);
        }, title: '', hasAppbar: false,error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getUsers(screenState);
        }, title: '', hasAppbar: false, emptyMessage: S.current.homeDataEmpty));
      } else {
         value as UsersModel;
        _stateSubject.add(HomeLoadedState(screenState,value.data));
      }
    });
  }
}
