import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/states/loading_state.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/global_nav_key.dart';
import 'package:trafficy_admin/module_main/state_manager/home_state_manager.dart';
import 'package:trafficy_admin/utils/components/custom_app_bar.dart';
import 'package:trafficy_admin/utils/images/images.dart';

@injectable
class HomeScreen extends StatefulWidget {
  final HomeStateManager _stateManager;

  HomeScreen(this._stateManager);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Trafficy.appBar(context,
          title: S.of(context).home, icon: Icons.menu, onTap: () {
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
      if (this.mounted) {
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
