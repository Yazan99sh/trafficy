import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marker_icon/marker_icon.dart';
import 'package:trafficy_client/abstracts/states/state.dart';
import 'package:trafficy_client/di/di_config.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_deep_links/service/deep_links_service.dart';
import 'package:trafficy_client/module_home/model/captains_model.dart';
import 'package:trafficy_client/module_home/ui/screen/home_screen.dart';
import 'package:trafficy_client/module_home/ui/widget/google_map_widget.dart';
import 'package:trafficy_client/module_home/ui/widget/marker.dart';
import 'package:trafficy_client/module_home/ui/widget/window_info.dart';
import 'package:trafficy_client/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:trafficy_client/utils/effect/hidder.dart';
import 'package:trafficy_client/utils/effect/scaling.dart';
import 'package:trafficy_client/utils/images/images.dart';
import 'package:latlong2/latlong.dart' as lat;

class HomeCaptainsStateLoaded extends States {
  HomeScreenState screenState;
  final List<CaptainsModel> captains;
  HomeCaptainsStateLoaded(
    this.screenState, {
    required this.captains,
  }) : super(screenState) {
    getCaptainsMarker(captains, screenState.globalKey).then((value) {
      markers = value;
      screenState.refresh();
    });
  }
  Set<Marker> markers = {};

  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        // Google Map
        SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            children: [
              MyMarker(screenState.globalKey),
              Positioned.fill(
                child: MapWidget(
                  markers: markers,
                  onTap: (position) {
                    screenState.customInfoWindowController.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    screenState.customInfoWindowController.onCameraMove!();
                  },
                  onMapCreated: (con) async {
                    screenState.customInfoWindowController.googleMapController =
                        con;
                    await con.setMapStyle(
                        getIt<ThemePreferencesHelper>().getStyleMode());
                    screenState.controller.complete(con);
                  },
                ),
              ),
              CustomInfoWindow(
                controller: screenState.customInfoWindowController,
                height: 100,
                width: 180,
                offset: 50,
              ),
            ],
          ),
        ),
        // Mentoring Panel
        Hider(
          active: screenState.controller.isCompleted,
          child: ScalingWidget(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 100,
                    ),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 25.0, left: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.university,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  screenState.timeToArrival != null
                                      ? '${screenState.timeToArrival}'
                                      : '${screenState.initDistance} ${S.current.km}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.7)),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            thickness: 2.5,
                            indent: 10,
                            endIndent: 10,
                            color: Theme.of(context).backgroundColor,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder()),
                            onPressed: () async {
                              var myLocation =
                                  await DeepLinksService.defaultLocation();
                              if (myLocation != null) {
                                LatLng latLng = LatLng(
                                    myLocation.latitude, myLocation.longitude);
                                GoogleMapController con =
                                    await screenState.controller.future;
                                await con.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                  zoom: 19,
                                  target: latLng,
                                )));
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.location_on_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          VerticalDivider(
                            thickness: 2.5,
                            indent: 10,
                            endIndent: 10,
                            color: Theme.of(context).backgroundColor,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 25.0, left: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.weight,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '${screenState.speedInKm.toStringAsFixed(2)} ${S.current.kmh}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.7)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }

  Future<Set<Marker>> getCaptainsMarker(
      List<CaptainsModel> captains, GlobalKey globalKey) async {
    Set<Marker> markers = {};
    for (var captain in captains) {
      if (captain.currentLocation == null) {
        continue;
      }
      markers.add(Marker(
          markerId: MarkerId(captain.uid),
          position: captain.currentLocation!,
          icon: captain.status
              ? await MarkerIcon.widgetToIcon(globalKey)
              : await MarkerIcon.pictureAsset(
                  assetPath: ImageAsset.BUS_DISABLE, width: 125, height: 125),
          onTap: () {
            DeepLinksService.getDistance(lat.LatLng(
                    captain.currentLocation!.latitude,
                    captain.currentLocation!.longitude))
                .then((value) {
              screenState.customInfoWindowController.addInfoWindow!(
                WindowInfoWidget(
                  distance: captain.speedInKmh == 0.0
                      ? value.toStringAsFixed(0) + ' ' + S.current.km
                      : (value / (captain.speedInKmh / 60)).toStringAsFixed(0) +
                          ' ' +
                          S.current.minute,
                  name: captain.name,
                  speed: '${captain.speedInKmh}',
                ),
                captain.currentLocation!,
              );
            });
          }));
    }
    return markers;
  }
}
