import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_admin/abstracts/states/empty_state.dart';
import 'package:trafficy_admin/abstracts/states/error_state.dart';
import 'package:trafficy_admin/abstracts/states/loading_state.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_captain/request/create_captain_account.dart';
import 'package:trafficy_admin/module_captain/service/captains_service.dart';
import 'package:trafficy_admin/module_clients/sceens/clients_screen.dart';
import 'package:trafficy_admin/module_clients/states/clients_loaded_state.dart';
import 'package:trafficy_admin/module_main/model/users_models.dart';
import 'package:trafficy_admin/module_main/service/home_service.dart';

@injectable
class ClientsStateManager {
  final HomeService _homeService;
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  ClientsStateManager(this._homeService, this._captainsService);

  void getUsers(ClientsScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _homeService.getUsersCount().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getUsers(screenState);
        }, title: '', hasAppbar: false, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getUsers(screenState);
        }, title: '', hasAppbar: false, emptyMessage: S.current.homeDataEmpty));
      } else {
        value as UsersModel;
        _stateSubject.add(ClientsLoadedState(screenState, value.data));
      }
    });
  }

  void createCaptainAccount(
      ClientsScreenState screenState, CreateCaptainAccount request) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService.createCaptainAccount(request).then((value) {
      if (value.hasError) {
        getUsers(screenState);
        // flush bar
      } else if (value.isEmpty) {
        getUsers(screenState);
        // flush bar
      } else {
        getUsers(screenState);
        // flush bar
      }
    });
  }
}
