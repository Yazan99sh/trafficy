import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trafficy_client/generated/l10n.dart';

class CustomDeliverySearch extends StatefulWidget {
  final double height;
  final EdgeInsetsGeometry contentPadding;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final bool autoFocus;
  final VoidCallback? onTap;
  final Color? background;
  @override
  _CustomDeliverySearchState createState() => _CustomDeliverySearchState();

  CustomDeliverySearch(
      {this.height = 50,
      this.controller,
      this.contentPadding = const EdgeInsets.fromLTRB(8, 0, 8, 0),
      required this.hintText,
      this.onChanged,
      this.readOnly = false,
      this.onTap,
      this.autoFocus = false,
      this.background});
}

class _CustomDeliverySearchState extends State<CustomDeliverySearch> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: widget.background != null
            ? widget.background
            : Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 8.0,
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: widget.controller,
                autofocus: widget.autoFocus,
                onChanged: widget.onChanged,
                readOnly: widget.readOnly,
                onTap: widget.onTap,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  enabledBorder: InputBorder.none,
                  contentPadding: widget.contentPadding,
                  focusedBorder: InputBorder.none,
                ),
              ),
            )
          ],
        ));
  }
}
