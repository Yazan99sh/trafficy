import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/states/loading_state.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/global_nav_key.dart';
import 'package:trafficy_admin/module_captain/state_manager/captains_state_manager.dart';
import 'package:trafficy_admin/module_captain/widget/create_captain_form.dart';
import 'package:trafficy_admin/utils/components/custom_app_bar.dart';
import 'package:trafficy_admin/utils/images/images.dart';

@injectable
class CaptainsScreen extends StatefulWidget {
  final CaptainsStateManager _stateManager;

  const CaptainsScreen(this._stateManager);

  @override
  CaptainsScreenState createState() => CaptainsScreenState();
}

class CaptainsScreenState extends State<CaptainsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Trafficy.appBar(context,
          title: S.of(context).captains, icon: Icons.menu, onTap: () {
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
      floatingActionButton: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CreateCaptainForm(
                    create: (request) {
                      widget._stateManager.createCaptainAccount(this, request);
                    },
                  );
                });
          },
          icon: const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Icon(Icons.add_rounded),
          ),
          label: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(S.current.createNewCaptain),
          )),
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
