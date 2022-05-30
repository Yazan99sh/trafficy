import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/consts/argument_type.dart';
import 'package:trafficy_admin/hive/arguments/ids_hive_helper.dart';

@injectable
class CustomNavigator {
  static pushNamed(BuildContext context,
      {required String routeName,
      ArgumentType? argumentType,
      String? role,
      dynamic argument}) {
    _setArgument(argumentType, role, argument);
    Navigator.of(context).pushNamed(routeName);
  }

  static void _setArgument(
      ArgumentType? argumentType, String? role, dynamic argument) {
    if (argument == null) {
      return;
    }
    if (argumentType == ArgumentType.ids) {
      if (role == 'captain') {
        IdsHiveHelper().setCaptainId(argument.toString());
      } else if (role == 'client') {
        IdsHiveHelper().setClientId(argument.toString());
      }
    }
  }
}
