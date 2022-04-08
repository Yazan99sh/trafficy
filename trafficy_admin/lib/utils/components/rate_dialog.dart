import 'package:flutter/material.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:trafficy_admin/utils/components/progresive_image.dart';
import 'package:trafficy_admin/utils/effect/hidder.dart';

class RatingAlertDialog extends StatelessWidget {
  final Function(double) onPressed;
  final String title;
  final String message;
  final String? image;
  RatingAlertDialog(
      {required this.onPressed,
      required this.message,
      required this.title,
      this.image});
  @override
  Widget build(BuildContext context) {
    double? _rate;
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
        title: Text(title),
        content: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            Hider(
              active: image != null,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomNetworkImage(
                        height: 125, width: 125, imageSource: image!)),
              ),
            ),
            RatingBar.builder(
              initialRating: 0,
              glowColor: Colors.amber,
              minRating: 0.0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
              onRatingUpdate: (rating) => _rate = rating,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
            )
          ],
        )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        actions: [
          SizedBox(
            width: double.maxFinite,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onPressed(_rate ?? 0);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(S.current.submit),
                )),
          ),
        ],
      ),
    );
  }
}
