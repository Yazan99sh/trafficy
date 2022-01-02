import 'package:flutter/src/widgets/framework.dart';
import 'package:trafficy_captain/abstracts/states/state.dart';
import 'package:flutter/material.dart';

class LoadingState extends States {
  LoadingState(State<StatefulWidget> screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
