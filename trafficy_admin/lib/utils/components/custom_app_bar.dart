import 'package:flutter/material.dart';

class Trafficy {
  static double borderRadius = 25;
  static PreferredSizeWidget appBar(
    BuildContext context, {
    required title,
    GestureTapCallback? onTap,
    Color? colorIcon,
    Color? buttonBackground,
    Color? background,
    IconData? icon,
    List<Widget>? actions,
    bool canGoBack = true,
  }) {
    return AppBar(
      backgroundColor: background ?? Theme.of(context).scaffoldBackgroundColor,
      actions: actions,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontWeight: FontWeight.bold,
            fontSize: 22),
      ),
      leading: canGoBack
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: InkWell(
                  borderRadius: BorderRadius.circular(borderRadius),
                  onTap: onTap ?? () => Navigator.of(context).pop(),
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    color: Theme.of(context).primaryColor,
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Center(
                      child: Icon(
                        icon ?? Icons.arrow_back,
                        color: colorIcon ?? Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
      elevation: 0,
    );
  }

  static Widget action(
      {required IconData icon,
      required VoidCallback onTap,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: Card(
          margin: EdgeInsets.zero,
          color: Theme.of(context).primaryColor,
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
