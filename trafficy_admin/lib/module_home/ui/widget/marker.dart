import 'package:flutter/material.dart';
import 'package:trafficy_admin/utils/images/images.dart';

class MyMarker extends StatelessWidget {
  // declare a global key and get it trough Constructor

  MyMarker(this.globalKeyMyWidget);
  final GlobalKey globalKeyMyWidget;

  @override
  Widget build(BuildContext context) {
    // wrap your widget with RepaintBoundary and
    // pass your global key to RepaintBoundary
    return RepaintBoundary(
      key: globalKeyMyWidget,
      child:Image.asset(ImageAsset.BUS,height: 125,
      width: 125,
      ));
  }
}
