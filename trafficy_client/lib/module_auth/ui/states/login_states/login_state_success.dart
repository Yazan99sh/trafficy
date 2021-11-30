import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:trafficy_client/module_auth/ui/states/login_states/login_state.dart';
import 'package:flutter/material.dart';

class LoginStateSuccess extends LoginState {
  final bool inited;
  LoginStateSuccess(LoginScreenState screen, this.inited) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo.jpg'),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          padding: EdgeInsets.all(16),
          onPressed: () {
            //screen.moveToNext(inited);
          },
          child: Text(S.of(context).welcomeTotrafficy_client),
        )
      ],
    );
  }
}
