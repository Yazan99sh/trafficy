import 'package:flutter/material.dart';
import 'package:trafficy_captain/generated/l10n.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  CustomListTile({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Text(title, style: TextStyle(fontSize: 14)),
        Container(
          height: 8,
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).disabledColor),
        )
      ],
    );
  }
}
