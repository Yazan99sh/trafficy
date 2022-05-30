import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/states/loading_state.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/global_nav_key.dart';
import 'package:trafficy_admin/module_captain/state_manager/captain_profile_state_manager.dart';
import 'package:trafficy_admin/utils/components/custom_app_bar.dart';

@injectable
class CaptainProfileScreen extends StatefulWidget {
  final CaptainProfileStateManager _stateManager;

  const CaptainProfileScreen(this._stateManager);

  @override
  CaptainProfileScreenState createState() => CaptainProfileScreenState();
}

class CaptainProfileScreenState extends State<CaptainProfileScreen> {
  CaptainProfileStateManager get manager => widget._stateManager;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Trafficy.appBar(
        context,
        title: S.of(context).captainProfile,
      ),
      body: state.getUI(context),
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
    widget._stateManager.getProfile(this);
    super.initState();
  }
}
