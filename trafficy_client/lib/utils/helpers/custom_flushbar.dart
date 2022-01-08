import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomFlushBarHelper {
  static Flushbar createSuccess(
      {required String title,
      required String message,
      int timeout = 4,
      Color? background,
      bool top = false,
      EdgeInsets? padding,
      EdgeInsets? margin}) {
    return Flushbar(
        maxWidth: 600,
        titleText: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          message,
          style: const TextStyle(
              color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor:background ?? Colors.green,
        duration: Duration(seconds: timeout),
        flushbarStyle: FlushbarStyle.GROUNDED,
        flushbarPosition: top ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
        boxShadows: [
          BoxShadow(
            color:background ?? Colors.green,
            offset: const Offset(0.0, 2.0),
            blurRadius: 5.0,
          )
        ]);
  }

  static Flushbar createError(
      {required String title,
      required String message,
      int timeout = 4,
      Color? background,
      bool top = true,
      EdgeInsets? padding,
      EdgeInsets? margin}) {
    return Flushbar(
        maxWidth: 600,
        titleText: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          message,
          style: const TextStyle(
              color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: timeout),
        flushbarStyle: FlushbarStyle.GROUNDED,
        flushbarPosition: top ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
        boxShadows: const [
          BoxShadow(
            color: Colors.red,
            offset: Offset(0.0, 2.0),
            blurRadius: 5.0,
          )
        ]);
  }
}
