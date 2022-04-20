import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/global_nav_key.dart';
import 'package:trafficy_admin/module_main/sceen/home_screen.dart';
import 'package:trafficy_admin/navigator_menu/navigator_menu.dart';
import 'package:trafficy_admin/utils/global/screen_type.dart';

@injectable
class MainScreen extends StatefulWidget {
  final HomeScreen _homeScreen;

  MainScreen(this._homeScreen);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  late StatefulWidget selectedPage;
  @override
  void initState() {
    selectedPage = widget._homeScreen;

    super.initState();
  }

  @override
  void didChangeMetrics() {
    setState(() {});
  }

  int pop = 2;
  @override
  Widget build(BuildContext context) {
    if (ScreenType.isDesktop(context)) {
      return Scaffold(
        body: Row(
          children: [
            NavigatorMenu(
              width: 300,
              currentPage: selectedPage,
              onTap: (selectedClass) {
                selectedPage = selectedClass;
                setState(() {});
              },
            ),
            Expanded(
              child: Scaffold(
                body: AnimatedSwitcher(
                  duration: Duration(milliseconds: 50),
                  child: selectedPage,
                ),
              ),
            )
          ],
        ),
      );
    }
    return WillPopScope(
      onWillPop: () async {
        pop = pop - 1;
        if (selectedPage != widget._homeScreen) {
          pop = 2;
          selectedPage = widget._homeScreen;
          setState(() {});
        } else {
          Fluttertoast.showToast(
              msg: S.current.exitWarning,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).disabledColor,
              fontSize: 16.0);
        }
        return pop <= 0;
      },
      child: GestureDetector(
        onTap: () {
          if (pop < 2) {
            pop = 2;
          }
        },
        child: Scaffold(
          key: GlobalVariable.mainScreenScaffold,
          drawer: NavigatorMenu(
            width: ScreenType.isTablet(context)
                ? MediaQuery.of(context).size.width * 0.4
                : MediaQuery.of(context).size.width * 0.75,
            currentPage: selectedPage,
            onTap: (selectedClass) {
              selectedPage = selectedClass;
              setState(() {});
            },
          ),
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 50),
            child: selectedPage,
          ),
        ),
      ),
    );
  }
}
