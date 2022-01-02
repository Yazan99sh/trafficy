import 'package:flutter/material.dart';
import 'package:trafficy_captain/generated/l10n.dart';

class MakeOrderButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  MakeOrderButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).cardColor.withOpacity(0.2),
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
            ]),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 65,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
