import 'package:flutter/material.dart';
class FixedContainer extends StatelessWidget {
  final Widget child;


  FixedContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(width: double.maxFinite,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: 600
          ),
          child:child,
        ),
      ),
    );
  }
}
