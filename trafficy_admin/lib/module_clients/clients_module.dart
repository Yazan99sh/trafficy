import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/module/yes_module.dart';
import 'package:trafficy_admin/module_clients/clients_routes.dart';
import 'package:trafficy_admin/module_clients/sceens/clients_screen.dart';

@injectable
class ClientsModule extends YesModule {
  final ClientsScreen clientsScreen;
  ClientsModule(this.clientsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {ClientsRoutes.CLIENTS_SCREEN: (context) => clientsScreen};
  }
}
