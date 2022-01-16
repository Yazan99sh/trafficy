import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_deep_links/service/deep_links_service.dart';
import 'package:trafficy_client/module_splash/splash_routes.dart';
import 'package:trafficy_client/utils/images/images.dart';

@injectable
class BlockScreen extends StatefulWidget {
  @override
  _BlockScreenState createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageAsset.TRAFFICY_LOGO,
                color: Colors.white,
                height: 150,
                width: 150,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).backgroundColor.withOpacity(0.5)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(S.current.serviceNotAvailable,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                            onPressed: () {
                              DeepLinksService.checkPermission();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  SplashRoutes.SPLASH_SCREEN, (route) => false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(S.current.retry),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
