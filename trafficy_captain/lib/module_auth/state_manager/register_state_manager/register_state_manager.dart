import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_captain/module_auth/enums/auth_status.dart';
import 'package:trafficy_captain/module_auth/request/register_request/register_request.dart';
import 'package:trafficy_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_captain/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:trafficy_captain/module_auth/ui/states/register_states/register_state.dart';
import 'package:trafficy_captain/module_auth/ui/states/register_states/register_state_code_sent.dart';
import 'package:trafficy_captain/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:trafficy_captain/module_auth/ui/states/register_states/register_state_success.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class RegisterStateManager {
  final AuthService _authService;
  final _registerStateSubject = PublishSubject<RegisterState>();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();
  late RegisterScreenState _registerScreen;
  bool registered = false;
  RegisterStateManager(this._authService) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _loadingStateSubject.add(AsyncSnapshot.nothing());
          _registerScreen.moveToNext();
          break;
        case AuthStatus.REGISTERED:
          registered = true;
          break;
        default:
          _loadingStateSubject.add(AsyncSnapshot.nothing());
          _registerStateSubject.add(RegisterStateInit(_registerScreen));
          break;
      }
    }).onError((err) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      _registerStateSubject.add(RegisterStateInit(_registerScreen,
          error: err, registered: registered));
    });
  }

  Stream<RegisterState> get stateStream => _registerStateSubject.stream;
  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  void registerClient(
      RegisterRequest request, RegisterScreenState _registerScreenState) {
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _registerScreen = _registerScreenState;
    _authService
        .registerApi(request)
        .whenComplete(() => _loadingStateSubject.add(AsyncSnapshot.nothing()));
  }
}
