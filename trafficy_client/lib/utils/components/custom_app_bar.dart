import 'package:flutter/material.dart';

class Trafficy {
  static PreferredSizeWidget appBar(
    BuildContext context, {
    required title,
    GestureTapCallback? onTap,
    Color? colorIcon,
    Color? buttonBackground,
    Color? background,
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
                  borderRadius: BorderRadius.circular(10),
                  onTap: onTap ?? () => Navigator.of(context).pop(),
                  child: Card(
                    margin: EdgeInsets.all(0),
                    color: Theme.of(context).primaryColor,
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
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
}
