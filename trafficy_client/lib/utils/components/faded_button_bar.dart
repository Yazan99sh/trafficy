import 'package:flutter/material.dart';

class FadedButtonBar extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  FadedButtonBar({required this.onPressed,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      constraints: BoxConstraints(
        maxWidth: 600
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).cardColor.withOpacity(0.95),
            offset: Offset(0,1),
            spreadRadius: 2,
            blurRadius: 25
          ),
        ],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).cardColor.withOpacity(0.0),
              Theme.of(context).cardColor.withOpacity(0.0),
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
            ]),
      ),
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width:double.maxFinite,
            child:  ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  )
              ),
              onPressed:onPressed,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(text,style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}