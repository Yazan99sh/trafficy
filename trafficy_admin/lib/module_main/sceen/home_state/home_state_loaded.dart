import 'package:flutter/material.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_main/model/users_models.dart';
import 'package:trafficy_admin/module_main/sceen/home_screen.dart';
import 'package:trafficy_admin/module_main/widget/animation.dart';
import 'package:trafficy_admin/utils/global/screen_type.dart';

class HomeLoadedState extends States {
  final HomeScreenState screenState;
  UsersModel usersModel;
  HomeLoadedState(this.screenState, this.usersModel) : super(screenState);

  String? id;

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: SizedBox(
        height: MediaQuery.of(context).size.height-16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          widgetTile(usersModel.captainsCount.toString(), S.current.captains),
          Divider(
            color: Theme.of(context).backgroundColor,
            thickness: 2.5,
          ),
          widgetTile(usersModel.clientsCount.toString(), S.current.clients),
        ]),
      ),
    );
  }

  Widget widgetTile(String count, String title) {
    var context = screenState.context;
    return SizedBox(
      width: !ScreenType.isDesktop(screenState.context)
          ? MediaQuery.of(screenState.context).size.width * 0.5
          : MediaQuery.of(screenState.context).size.width * 0.25,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: AnimatedLiquidCircularProgressIndicator(
                ValueKey(title), int.parse(count)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 180),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.85),
                  Theme.of(context).colorScheme.primary.withOpacity(0.9),
                  Theme.of(context).colorScheme.primary.withOpacity(0.95),
                  Theme.of(context).colorScheme.primary,
                ]),
                color: Theme.of(screenState.context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
