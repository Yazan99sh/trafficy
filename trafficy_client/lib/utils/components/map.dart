import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapClientOrder extends StatefulWidget {
  final MapController _mapController;
  final Function(LatLng) onTap;
  final LatLng? myPos;
  final LatLng? defaultPoint;
  MapClientOrder(this._mapController, {Key? key,required this.onTap ,this.myPos,this.defaultPoint}) : super(key:key);

  @override
  _MapClientOrderState createState() => _MapClientOrderState();
}

class _MapClientOrderState extends State<MapClientOrder> {
  LatLng? clientAddress;

  @override
  void initState() {
    if (widget.defaultPoint != null){
      clientAddress = widget.defaultPoint;
    }
    widget._mapController.mapEventStream.listen((event) {
      if (event is MapEventMove && clientAddress == null) {
        clientAddress = event.targetCenter;
        saveMarker(clientAddress!);
        if (mounted) {
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget._mapController,
      options: MapOptions(
        center: widget.myPos ?? LatLng(21.5429423, 39.1690945),
        zoom: 17.0,
        onTap: (newPos) {
          saveMarker(newPos);
          widget.onTap(newPos);
          setState(() {});
        },
      ),
      layers: [
      TileLayerOptions(
      urlTemplate: 'https://mt.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
      subdomains: ['a', 'b', 'c'],
    ),
    MarkerLayerOptions(
    markers: clientAddress == null ? [] : _getMarkers(context),
    ),
    ],
    );
  }

  void saveMarker(LatLng location) {
    clientAddress = location;
  }

  List<Marker> _getMarkers(BuildContext context) {
    if (clientAddress == null) return <Marker>[];
    return [
      Marker(
        point: clientAddress!,
        builder: (ctx) => Container(
          child: Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 35,
          ),
        ),
      )
    ];
  }
}
