import 'package:injectable/injectable.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_client/utils/images/images.dart';
import 'package:flutter/material.dart';


@injectable
class SplashScreen extends StatefulWidget {
  final AuthService _authService;
  SplashScreen(
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
    var paddingOfImage = MediaQuery.of(context).size.height * 0.20;
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.only(top:paddingOfImage,bottom: 24),
            child: Image.asset(ImageAsset.LOGO,height: 200,width: 200,),
          ),
          Spacer(flex: 1,),
          Image.asset(ImageAsset.DELIVERY_MOTOR,fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,),
        ],
      ),
    );
  }

  Future<String> _getNextRoute() async {
    await Future.delayed(Duration(seconds: 2));
    return 'MainRoutes.MAIN_SCREEN';
  }

}
