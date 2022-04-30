import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/states/loading_state.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/global_nav_key.dart';
import 'package:trafficy_admin/module_statistics/state_manager/preview_state_manager.dart';
import 'package:trafficy_admin/utils/components/custom_app_bar.dart';

@injectable
class PreviewScreen extends StatefulWidget {
  final PreviewStateManager _stateManager;

  PreviewScreen(this._stateManager);

  @override
  PreviewScreenState createState() => PreviewScreenState();
}

class PreviewScreenState extends State<PreviewScreen> {
  MapController? mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Trafficy.appBar(context,
            title: S.of(context).home, icon: Icons.menu, onTap: () {
          GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
        }),
        body: state.getUI(context));
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
    widget._stateManager.stateSubject.listen((event) {
      state = event;
      if (mounted) {
        setState(() {});
      }
    });
    getReport();
    super.initState();
  }

  void getReport() {
    widget._stateManager.getAllUserLocations(this);
  }
}
