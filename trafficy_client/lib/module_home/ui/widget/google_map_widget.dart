import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final void Function(GoogleMapController)? onMapCreated;
  final Set<Marker> markers;
  final Function(LatLng)? onTap;
  final Function(CameraPosition)? onCameraMove;
  const MapWidget(
      {Key? key,
      this.onMapCreated,
      this.onTap,
      this.onCameraMove,
      this.markers = const <Marker>{}})
      : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      child: GoogleMap(
          onTap: widget.onTap,
          onCameraMove: widget.onCameraMove,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          onMapCreated: widget.onMapCreated,
          markers: widget.markers,
          initialCameraPosition:
              const CameraPosition(target: LatLng(36.747061, 36.1618916))),
    );
  }
}
