import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class AnimatedLiquidCircularProgressIndicator extends StatefulWidget {
  final int count;

  AnimatedLiquidCircularProgressIndicator(Key? key, this.count);

  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidCircularProgressIndicatorState();
}

class _AnimatedLiquidCircularProgressIndicatorState
    extends State<AnimatedLiquidCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animationController.addListener(() {
      setState(() {});
    });
    //_animationController.repeat();
    if (widget.count > 0) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    final cnt = (widget.count * percentage) / 100;
    return Center(
      child: SizedBox(
        width: 100.0,
        height: 100.0,
        child: LiquidCircularProgressIndicator(
          key: widget.key,
          value: _animationController.value,
          valueColor: AlwaysStoppedAnimation(
            Theme.of(context).colorScheme.primary.withOpacity(0.4),
          ), // Defaults to the current Theme's accentColor.
          backgroundColor: Theme.of(context)
              .scaffoldBackgroundColor, // Defaults to the current Theme's backgroundColor.
          borderColor: Theme.of(context).colorScheme.primary,
          borderWidth: 2,
          direction: Axis.vertical, //
          center: Center(
            child: Text(
              cnt.toStringAsFixed(0),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
        ),
      ),
    );
  }
}
