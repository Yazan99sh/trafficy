import 'package:flutter/material.dart';
class Hider extends StatelessWidget {
  final bool active;
  final Widget child;
  Hider({required this.active,required this.child});

  @override
  Widget build(BuildContext context) {
    if (active) {
      return child;
    }
    else {
      return SizedBox();
    }
  }
}
class HiderWithDivider extends StatelessWidget {
  final bool active;
  final Widget child;
  final Widget divider;
  final Axis direction;
  HiderWithDivider({required this.active,required this.child,required this.divider,required this.direction});

  @override
  Widget build(BuildContext context) {
    if (active) {
      return Flex(
        direction: direction,
        children: [
          child,
          divider
        ],
      );
    }
    else {
      return SizedBox();
    }
  }
}
