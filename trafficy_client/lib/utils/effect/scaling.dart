import 'package:flutter/cupertino.dart';

class ScalingWidget extends StatelessWidget {
  final Widget child;
  final int? milliseconds;
  final bool fade;

  ScalingWidget({required this.child,this.milliseconds,this.fade = false});

  @override
  Widget build(BuildContext context) {
    if (fade){
      return TweenAnimationBuilder(
        duration: Duration(milliseconds:milliseconds ?? 750),
        tween: Tween<double>(begin: 0.1, end: 1),
        curve: Curves.easeInOut,
        builder: (context, double val,_) {
          return Opacity(
            opacity: val,
            child: child,
          );
        },
      );
    }
    return TweenAnimationBuilder(
      duration: Duration(milliseconds:milliseconds ?? 750),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeInOut,
      builder: (context, double val,_) {
        return Transform.scale(
          scale: val,
          child: child,
        );
      },
    );
  }
}
