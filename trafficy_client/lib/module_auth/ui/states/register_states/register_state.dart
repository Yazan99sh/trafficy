import 'package:trafficy_client/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:flutter/material.dart';

abstract class RegisterState {
  final RegisterScreenState screen;
  RegisterState(this.screen);

  Widget getUI(BuildContext context);
}
