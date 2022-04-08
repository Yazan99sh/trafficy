import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:trafficy_admin/module_auth/ui/states/register_states/register_state.dart';
import 'package:flutter/material.dart';

class RegisterStateSuccess extends RegisterState {
  RegisterStateSuccess(RegisterScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Center(
            child: Image.asset('assets/images/logo.jpg'),
          ),
        ),
        RaisedButton(
          padding: EdgeInsets.all(8),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            screen.moveToNext();
          },
          child: Text(
            S.of(context).registerSuccessSetupMyProfile,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
