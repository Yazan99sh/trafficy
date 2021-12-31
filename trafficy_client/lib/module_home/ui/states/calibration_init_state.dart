import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:trafficy_client/abstracts/states/state.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_deep_links/service/deep_links_service.dart';
import 'package:trafficy_client/module_home/ui/screen/calibration_screen.dart';
import 'package:trafficy_client/utils/effect/scaling.dart';
import 'package:trafficy_client/utils/images/images.dart';

class CalibrationInitState extends States {
  CalibrationScreenState screenState;
  CalibrationInitState(this.screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ScalingWidget(
            child: Flushbar(
              boxShadows: [
                BoxShadow(
                    color: Theme.of(context).primaryColor,
                    offset: const Offset(1, 1),
                    blurRadius: 5,
                    spreadRadius: 1),
              ],
              shouldIconPulse: true,
              icon: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(25),
              backgroundColor: Theme.of(context).primaryColor,
              titleText: Text(
                S.current.warnning,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              messageText: Text(
                S.current.calibrationHint,
                style: const TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Lottie.asset(
              LottieAsset.CALIBRATION_SCREEN,
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: SizedBox(
                            width: double.maxFinite,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25))),
                                onPressed: () async {
                                  var location =
                                      await DeepLinksService.defaultLocation();
                                  if (location != null) {
                                    screenState.createLocation(location);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.current.confirm),
                                ))),
                      ),
                      Divider(
                        thickness: 2.5,
                        indent: 50,
                        endIndent: 50,
                        color: Theme.of(context).backgroundColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: SizedBox(
                            width: double.maxFinite,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25))),
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.current.skip),
                                ))),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
