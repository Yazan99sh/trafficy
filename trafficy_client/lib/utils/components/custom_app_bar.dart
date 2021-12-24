import 'package:flutter/material.dart';
class CustomTwaslnaAppBar {
  static PreferredSizeWidget appBar(BuildContext context,
      {required title,
      GestureTapCallback? onTap,
      Color? colorIcon,
      Color? buttonBackground,
      Color? background,
      List<Widget>? actions,
      bool canGoBack = true,
      }) {
    return AppBar(
      backgroundColor:background ?? Theme.of(context).scaffoldBackgroundColor,
      actions: actions,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontWeight: FontWeight.bold,fontSize: 22),
      ),
      leading: canGoBack ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap ?? () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                color: buttonBackground ?? Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  color: colorIcon ?? Colors.white,
                ),
              ),
            ),
          ),
        ),
      ) : null,
      elevation: 0,
    );
  }
}
