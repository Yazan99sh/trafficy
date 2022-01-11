import 'package:clippy_flutter/triangle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trafficy_client/utils/effect/scaling.dart';

class WindowInfoWidget extends StatelessWidget {
  final String name;
  final String speed;
  final String distance;
  const WindowInfoWidget({
    Key? key,
    required this.name,
    required this.speed,
    required this.distance,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScalingWidget(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).disabledColor),
                    ),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.weight,
                            color: Theme.of(context).primaryColor,
                          ),
                      const SizedBox(width: 8,),
                          Text(
                            speed,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Theme.of(context).disabledColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:8.0,left: 8.0),
                            child: Container(
                              height: 24,
                              width: 2.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).primaryColor.withOpacity(0.5)
                              ),
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.road,
                            color: Theme.of(context).primaryColor,
                          ),
                      const SizedBox(width: 8,),
                          Text(
                            distance,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Theme.of(context).disabledColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Triangle.isosceles(
            edge: Edge.BOTTOM,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(25)),
              width: 20.0,
              height: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}
