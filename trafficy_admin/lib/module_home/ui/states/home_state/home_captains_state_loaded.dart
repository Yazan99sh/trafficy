import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/module_home/model/captains_model.dart';
import 'package:trafficy_admin/module_home/ui/screen/home_screen.dart';
import 'package:trafficy_admin/utils/images/images.dart';

class HomeCaptainsStateLoaded extends States {
  HomeScreenState screenState;
  final List<CaptainsModel> captains;
  HomeCaptainsStateLoaded(
    this.screenState, {
    required this.captains,
  }) : super(screenState) {
    getCaptainsMarker(captains, screenState.globalKey).then((value) {
   //   markers = value;
      screenState.refresh();
    });
  }
  @override
  Widget getUI(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return Text("© OpenStreetMap contributors");
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Container(
                child: FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<List<Marker>> getCaptainsMarker(
      List<CaptainsModel> captains, GlobalKey globalKey) async {
    List<Marker> markers = [];
    for (var captain in captains) {
      if (captain.currentLocation == null) {
        continue;
      }
      markers.add(Marker(
        point: LatLng(captain.currentLocation?.latitude ?? 0,
            captain.currentLocation?.longitude ?? 0),
        builder: (BuildContext context) {
          return Container();
        },
      ));
    }
    return markers;
  }
}
