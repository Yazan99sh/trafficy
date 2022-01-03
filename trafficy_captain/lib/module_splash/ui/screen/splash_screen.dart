import 'package:appwrite/appwrite.dart';
import 'package:injectable/injectable.dart';
import 'package:lottie/lottie.dart';
import 'package:trafficy_captain/consts/urls.dart';
import 'package:trafficy_captain/di/di_config.dart';
import 'package:trafficy_captain/module_auth/authorization_routes.dart';
import 'package:trafficy_captain/module_auth/presistance/auth_prefs_helper.dart';
import 'package:trafficy_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_captain/module_home/home_routes.dart';
import 'package:trafficy_captain/utils/effect/hidder.dart';
import 'package:trafficy_captain/utils/images/images.dart';
import 'package:flutter/material.dart';

@injectable
class SplashScreen extends StatefulWidget {
  final AuthService _authService;
  const SplashScreen(
    this._authService,
  );
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _getNextRoute().then((route) {
        Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Client client = Client();
    client.setEndpoint(Urls.APPWRITE_ENDPOINT);
    client.setProject(Urls.APPWRITE_PROJECTID);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hider(
          active: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Image.asset(
              ImageAsset.TRAFFICY_LOGO,
              height: 150,
              width: 150,
            ),
          ),
        ),
        Lottie.asset(LottieAsset.SPLASH_SCREEN),
        SizedBox(height: 150, child: Lottie.asset(LottieAsset.LOADING_SCREEN)),
      ],
    ));
  }

  Future<String> _getNextRoute() async {
    await Future.delayed(const Duration(seconds: 2));
    if (widget._authService.isLoggedIn) {
      return HomeRoutes.HOME_SCREEN;
    }
    return AuthorizationRoutes.LOGIN_SCREEN;
  }
}
