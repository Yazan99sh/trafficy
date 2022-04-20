import 'package:flutter/material.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_main/sceen/home_screen.dart';
import 'package:trafficy_admin/module_main/widget/animation.dart';
import 'package:trafficy_admin/utils/components/empty_screen.dart';
import 'package:trafficy_admin/utils/components/error_screen.dart';
import 'package:trafficy_admin/utils/global/screen_type.dart';

class HomeLoadedState extends States {
  final HomeScreenState screenState;
  final String? error;
  final bool empty;

  HomeLoadedState(this.screenState,
      {this.empty = false, this.error})
      : super(screenState);

  String? id;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getReport();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.homeDataEmpty,
          onRefresh: () {
            screenState.getReport();
          });
    }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: SizedBox(
        child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            children: const [
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
