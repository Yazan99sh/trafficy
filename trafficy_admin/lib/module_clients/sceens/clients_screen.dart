import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/states/loading_state.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/global_nav_key.dart';
import 'package:trafficy_admin/module_clients/state_manager/clients_state_manager.dart';
import 'package:trafficy_admin/utils/components/custom_app_bar.dart';
import 'package:trafficy_admin/utils/images/images.dart';

@injectable
class ClientsScreen extends StatefulWidget {
  final ClientsStateManager _stateManager;

  const ClientsScreen(this._stateManager);

  @override
  ClientsScreenState createState() => ClientsScreenState();
}

class ClientsScreenState extends State<ClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Trafficy.appBar(context,
          title: S.of(context).clients, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      ImageAsset.BUS,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ))),
          ),
          state.getUI(context)
        ],
      ),
    );
  }

  late States state;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    state = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      state = event;
      if (mounted) {
        setState(() {});
      }
    });
    getReport();
    super.initState();
  }

  void getReport() {
    widget._stateManager.getUsers(this);
  }
}
