import 'dart:async';
import 'package:appwrite/appwrite.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_captain/consts/urls.dart';
import 'package:trafficy_captain/di/di_config.dart';
import 'package:trafficy_captain/generated/l10n.dart';
import 'package:trafficy_captain/module_auth/presistance/auth_prefs_helper.dart';
import 'package:trafficy_captain/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:trafficy_captain/module_auth/ui/states/login_states/login_state.dart';
import 'package:trafficy_captain/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:flutter/material.dart';
import 'package:trafficy_captain/module_home/home_routes.dart';
import 'package:trafficy_captain/module_splash/splash_routes.dart';
import 'package:trafficy_captain/utils/components/custom_app_bar.dart';
import 'package:trafficy_captain/utils/helpers/custom_flushbar.dart';

@injectable
class LoginScreen extends StatefulWidget {
  final LoginStateManager _stateManager;

  LoginScreen(this._stateManager);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late LoginState _currentStates;
  late AsyncSnapshot loadingSnapshot;
  late StreamSubscription _stateSubscription;
  bool deepLinkChecked = false;
  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    loadingSnapshot = const AsyncSnapshot.nothing();
    _currentStates = LoginStateInit(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          _currentStates = event;
        });
      }
    });
    widget._stateManager.loadingStream.listen((event) {
      if (mounted) {
        setState(() {
          loadingSnapshot = event;
        });
      }
    });
    super.initState();
  }

  dynamic args;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: Trafficy.appBar(context,
            title: S.of(context).login, canGoBack: false),
        body: loadingSnapshot.connectionState != ConnectionState.waiting
            ? _currentStates.getUI(context)
            : Stack(
                children: [
                  _currentStates.getUI(context),
                  Container(
                    width: double.maxFinite,
                    color: Colors.transparent.withOpacity(0.0),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }

  void loginClient(String email, String password) {
    widget._stateManager.loginClient(email, password, this);
  }

  void moveToNext() {
    if (getIt<AuthPrefsHelper>().isCalibrated()) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeRoutes.HOME_SCREEN, (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeRoutes.CALIBRATION_SCREEN, (route) => false);
    }
    CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.loginSuccess)
        .show(context);
  }
}
