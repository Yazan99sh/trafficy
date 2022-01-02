import 'package:flutter/material.dart';
import 'package:trafficy_captain/generated/l10n.dart';

class CustomAlertDialog extends StatelessWidget {
  final VoidCallback? onPressed;
  final String content;
  final String? title;
  CustomAlertDialog(
      {required this.onPressed, required this.content, this.title});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 450),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.linear,
      builder: (context, double val, child) {
        return Transform.scale(
          scale: val,
          child: child,
        );
      },
      child: AlertDialog(
        title: Text(title ?? S.current.warnning),
        content: Container(child: Text(content)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        actions: [
          TextButton(onPressed: onPressed, child: Text(S.current.confirm)),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.current.cancel)),
        ],
      ),
    );
  }
}
