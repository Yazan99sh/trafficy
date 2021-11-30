import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:trafficy_client/module_auth/ui/states/login_states/login_state.dart';
import 'package:trafficy_client/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:flutter/material.dart';
import 'package:trafficy_client/utils/components/custom_app_bar.dart';
import 'package:trafficy_client/utils/helpers/custom_flushbar.dart';

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

  int? returnToMainScreen;
  bool? returnToPreviousScreen;
  @override
  void initState() {
    loadingSnapshot = AsyncSnapshot.nothing();
    _currentStates = LoginStateInit(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          _currentStates = event;
        });
      }
    });
    widget._stateManager.loadingStream.listen((event) {
      if (this.mounted) {
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
    args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      if (args is bool) returnToPreviousScreen = args;
      if (args is int) returnToMainScreen = args;
    }
    return WillPopScope(
      onWillPop: () async {
        // await Navigator.of(context)
        //     .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
         return returnToMainScreen == null;
      },
      child: GestureDetector(
        onTap: () {
          var focus = FocusScope.of(context);
          if (focus.canRequestFocus) {
            focus.unfocus();
          }
        },
        child: Scaffold(
          appBar: CustomTwaslnaAppBar.appBar(context,
              title: S.of(context).login,
              onTap: returnToMainScreen != null
                  ? () {

                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     MainRoutes.MAIN_SCREEN, (route) => false);

                    }
                  : null),
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
    if (returnToMainScreen != null) {
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     MainRoutes.MAIN_SCREEN, (route) => false,
      //     arguments: returnToMainScreen);
    
    } else if (returnToPreviousScreen != null) {
      Navigator.of(context).pop();
    } else {
      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
    
    }
    CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.loginSuccess)
        .show(context);
  }
}
