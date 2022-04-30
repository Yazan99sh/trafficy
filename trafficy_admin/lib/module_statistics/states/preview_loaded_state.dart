import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/module_statistics/model/captains_model.dart';
import 'package:trafficy_admin/module_statistics/model/clients_model.dart';
import 'package:trafficy_admin/module_statistics/sceens/preview_screen.dart';
import 'package:trafficy_admin/utils/images/images.dart';

class PreviewLoadedState extends States {
  final PreviewScreenState screenState;
  List<CaptainsModel> captains;
  List<ClientsModel> clients;
  LatLng? myPos;
  PreviewLoadedState(this.screenState,
      {required this.captains, required this.clients, this.myPos})
      : super(screenState) {
    if (myPos != null) {
      screenState.mapController?.move(myPos!, 17.0);
      screenState.refresh();
    }
  }

  @override
  Widget getUI(BuildContext context) {
    return FlutterMap(
      mapController: screenState.mapController,
      options: MapOptions(
        center: myPos ?? LatLng(21.5429423, 39.1690945),
        zoom: 17.0,
        onTap: (tap, coords) {},
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://mt.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
          subdomains: [],
        ),
        MarkerLayerOptions(
          markers: _getMarkers(context),
        ),
      ],
    );
  }

  List<Marker> _getMarkers(BuildContext context) {
    List<Marker> markers = [];
    captains.forEach((element) {
      markers.add(Marker(
          point: element.currentLocation ?? LatLng(0, 0),
          width: 65,
          height: 65,
          builder: (ctx) {
            return SizedBox(
              child: Image.asset(
                element.status ? ImageAsset.BUS : ImageAsset.BUS_DISABLE,
                width: 125,
                height: 125,
              ),
            );
          }));
    });

    clients.forEach((element) {
      markers.add(Marker(
          point: element.homeLocation ?? LatLng(0, 0),
          builder: (ctx) {
            return Container(
              child: Icon(
                Icons.location_pin,
                size: 65,
                color: Colors.red[900],
              ),
            );
          }));
    });
    print(markers.length);
    return markers;
  }
}
