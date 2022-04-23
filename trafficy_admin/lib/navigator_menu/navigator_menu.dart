import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trafficy_admin/di/di_config.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/global_nav_key.dart';
import 'package:trafficy_admin/module_captain/captains_module.dart';
import 'package:trafficy_admin/module_main/main_module.dart';
import 'package:trafficy_admin/module_settings/settings_module.dart';
import 'package:trafficy_admin/utils/components/custom_list_view.dart';
import 'package:trafficy_admin/utils/images/images.dart';

// current last index is 19
class NavigatorMenu extends StatefulWidget {
  final Function(StatefulWidget) onTap;
  final StatefulWidget currentPage;
  final double? width;
  NavigatorMenu({this.width, required this.onTap, required this.currentPage});

  @override
  _NavigatorMenuState createState() => _NavigatorMenuState();
}

class _NavigatorMenuState extends State<NavigatorMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var drawerHeader = SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Center(
                child: Image.asset(
              ImageAsset.BUS,
              width: 75,
            )),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
    return SafeArea(
      child: Container(
          width: widget.width,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: Localizations.localeOf(context).languageCode == 'ar'
                  ? const BorderRadius.horizontal(left: Radius.circular(12))
                  : const BorderRadius.horizontal(right: Radius.circular(12))),
          child: CustomListView.custom(children: [
            drawerHeader,
            customListTile(getIt<MainModule>().homeScreen, S.current.home,
                FontAwesomeIcons.home),
            customListTile(getIt<CaptainsModule>().captainsScreen,
                S.current.captains, FontAwesomeIcons.motorcycle),
            customListTile(getIt<SettingsModule>().settingsScreen,
                S.current.settings, FontAwesomeIcons.cog),
          ])),
    );
  }

  Widget customListTile(StatefulWidget page, String title, IconData icon,
      [bool subtitle = false]) {
    bool selected = page.runtimeType.toString() ==
        widget.currentPage.runtimeType.toString();
    double? size =
        icon.fontPackage == 'font_awesome_flutter' ? (subtitle ? 18 : 22) : 26;
    if (size == 26 && subtitle) {
      size = 20;
    }

    return Padding(
      key: ValueKey(page.runtimeType),
      padding: EdgeInsets.only(
          left: subtitle ? 16.0 : 8.0,
          right: subtitle ? 16 : 8.0,
          bottom: selected ? 8 : 0,
          top: selected ? 8 : 0),
      child: Container(
        decoration: BoxDecoration(
            color: selected ? Theme.of(context).colorScheme.primary : null,
            borderRadius: BorderRadius.circular(25),
            boxShadow: selected
                ? [
                    BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                        offset: Offset(1, 1)),
                  ]
                : null,
            gradient: selected
                ? LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    Theme.of(context).colorScheme.primary.withOpacity(0.9),
                    Theme.of(context).colorScheme.primary,
                  ])
                : null),
        child: ListTile(
          minLeadingWidth: subtitle ? 4 : null,
          visualDensity: VisualDensity(vertical: -2),
          onTap: () {
            widget.onTap(page);
            GlobalVariable.mainScreenScaffold.currentState?.openEndDrawer();
            setState(() {});
          },
          leading:
              Icon(icon, color: selected ? Colors.white : null, size: size),
          title: Text(
            title,
            style: TextStyle(
                color: selected ? Colors.white : null,
                fontSize: subtitle ? 14 : null),
          ),
        ),
      ),
    );
  }

  Widget customExpansionTile(
      {required StatefulWidget page,
      required String title,
      required IconData icon,
      required List<Widget> children}) {
    bool extended = false;
    for (var i in children) {
      if (i.key.toString() == '[<${page.runtimeType}>]') {
        extended = true;
        break;
      }
    }
    double? size = icon.fontPackage == 'font_awesome_flutter' ? 22 : 26;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: extended,
          title: Text(title),
          leading: Icon(
            icon,
            size: size,
          ),
          children: children,
        ),
      ),
    );
  }
}
