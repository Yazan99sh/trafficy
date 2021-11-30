import 'package:flutter/material.dart';
class Checked extends StatelessWidget {
  final bool checked;
  final Widget child;
  final Widget checkedWidget;

  Checked({required this.checked,required this.child,required this.checkedWidget});

  @override
  Widget build(BuildContext context) {
    if (checked) {
      return checkedWidget;
    }
    else {
      return child;
    }
  }
}
