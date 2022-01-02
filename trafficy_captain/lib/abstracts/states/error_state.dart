import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trafficy_captain/abstracts/states/state.dart';
import 'package:trafficy_captain/generated/l10n.dart';
import 'package:trafficy_captain/utils/components/custom_app_bar.dart';
import 'package:trafficy_captain/utils/images/images.dart';

class ErrorState extends States {
  final String? error;
  final List<String>? errors;
  final String title;
  final bool hasAppbar;
  final VoidCallback onPressed;
  State<StatefulWidget> screenState;
  ErrorState(this.screenState,
      {this.error,
      this.errors,
      required this.onPressed,
      required this.title,
      this.hasAppbar = true})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: hasAppbar
          ? Trafficy.appBar(context, title: title, buttonBackground: Colors.red)
          : null,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flushbar(
                  title: S.of(context).thisErrorHappened,
                  message: error,
                  icon: Icon(
                    Icons.info,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  flushbarStyle: FlushbarStyle.FLOATING,
                ),
              ),
              Container(
                height: 24,
              ),
              SvgPicture.asset(
                ImageAsset.ERROR_SVG,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Container(
                height: 32,
              ),
              Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0),
                      onPressed: onPressed,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).refresh,
                          style: TextStyle(color: Colors.white),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
