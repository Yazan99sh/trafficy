import 'package:flutter/material.dart';
abstract class States{

  final State<StatefulWidget> state;

  States(this.state);

  Widget getUI(BuildContext context);

}