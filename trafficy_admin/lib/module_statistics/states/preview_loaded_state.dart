import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_statistics/model/captains_model.dart';
import 'package:trafficy_admin/module_statistics/model/clients_model.dart';
import 'package:trafficy_admin/module_statistics/sceens/preview_screen.dart';
import 'package:trafficy_admin/module_statistics/widget/example_pop.dart';
import 'package:trafficy_admin/module_statistics/widget/widget_info.dart';
import 'package:trafficy_admin/utils/effect/scaling.dart';
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
  final PopupController _popupLayerController = PopupController();
  @override
  Widget getUI(BuildContext context) {
    return FlutterMap(
      mapController: screenState.mapController,
      options: MapOptions(
        center: myPos ?? LatLng(21.5429423, 39.1690945),
        zoom: 17.0,
        onTap: (tap, coords) {
          _popupLayerController.hideAllPopups();
        },
      ),
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: 'https://mt.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
            subdomains: [],
          ),
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
              popupController: _popupLayerController,
              markers: _getMarkers(context),
              markerRotateAlignment:
                  PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
              popupBuilder: (BuildContext context, Marker marker) {
                if (marker.key is ObjectKey) {
                  var k = marker.key as ObjectKey;
                  if (k.value is ClientsModel) {
                    return PopupWindowInfo(
                      clientsModel: k.value as ClientsModel,
                    );
                  }
                  if (k.value is CaptainsModel) {
                    return PopupWindowInfo(
                      captainsModel: k.value as CaptainsModel,
                    );
                  }
                }
                return PopupWindowInfo();
              }),
        ),
      ],
    );
  }

  bool window = false;
  List<Marker> _getMarkers(BuildContext context) {
    List<Marker> markers = [];
    captains.forEach((element) {
      markers.add(Marker(
          key: ObjectKey(element),
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
          key: ObjectKey(element),
          width: 45,
          height: 45,
          anchorPos: AnchorPos.align(AnchorAlign.top),
          point: element.homeLocation ?? LatLng(0, 0),
          builder: (ctx) {
            return Icon(
              Icons.location_on,
              size: 45,
              color: Colors.red[900],
            );
          }));
    });
    return markers;
  }
}
