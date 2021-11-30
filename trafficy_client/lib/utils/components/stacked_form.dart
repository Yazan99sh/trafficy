import 'package:flutter/material.dart';
import 'package:trafficy_client/utils/components/faded_button_bar.dart';

class StackedForm extends StatelessWidget {
  final Widget child;
  final String label;
  final VoidCallback onTap;

  StackedForm({required this.child, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Align(
            alignment: Alignment.bottomCenter,
            child: FadedButtonBar(onPressed: onTap, text: label)),
      ],
    );
  }
}
